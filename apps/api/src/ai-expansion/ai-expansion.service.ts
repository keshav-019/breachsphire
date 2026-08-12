import { BadRequestException, Injectable, NotFoundException } from "@nestjs/common";
import { and, desc, eq } from "drizzle-orm";
import type {
  AiIncidentAttempt,
  AiIncidentDetail,
  AiIncidentEvidence,
  AiIncidentSummary,
  AiInterviewAttempt,
  AiInterviewQuestion,
  AiPracticeOverview,
} from "@cyber-guardians/types";
import { db } from "../db/client";
import {
  aiInterviewQuestions,
  aiOnCallIncidents,
  playerAiIncidentAttempts,
  playerAiInterviewAttempts,
} from "../db/schema";

function strings(value: unknown): string[] {
  return Array.isArray(value) ? value.filter((item): item is string => typeof item === "string") : [];
}

function evidence(value: unknown): AiIncidentEvidence[] {
  if (!Array.isArray(value)) return [];
  return value.filter(
    (item): item is AiIncidentEvidence =>
      typeof item === "object" && item !== null &&
      typeof (item as AiIncidentEvidence).label === "string" &&
      typeof (item as AiIncidentEvidence).detail === "string",
  );
}

function incidentAttemptDto(row: typeof playerAiIncidentAttempts.$inferSelect): AiIncidentAttempt {
  return {
    id: row.id,
    diagnosis: row.diagnosis,
    mitigation: row.mitigation,
    score: row.score,
    feedback: strings(row.feedback),
    createdAt: row.createdAt.toISOString(),
  };
}

function interviewAttemptDto(row: typeof playerAiInterviewAttempts.$inferSelect): AiInterviewAttempt {
  return {
    id: row.id,
    answer: row.answer,
    score: row.score,
    matchedSignals: strings(row.matchedSignals),
    feedback: strings(row.feedback),
    createdAt: row.createdAt.toISOString(),
  };
}

function scoreResponse(text: string, signals: string[]) {
  const normalized = text.toLocaleLowerCase();
  const matched = signals.filter((signal) => normalized.includes(signal.toLocaleLowerCase()));
  const coverage = signals.length ? matched.length / signals.length : 0;
  const depth = Math.min(1, text.trim().split(/\s+/).filter(Boolean).length / 140);
  return { matched, score: Math.min(100, Math.round(coverage * 75 + depth * 25)) };
}

@Injectable()
export class AiExpansionService {
  async overview(playerId: string): Promise<AiPracticeOverview> {
    const [incidents, incidentAttempts, questions, interviewAttempts] = await Promise.all([
      db.select({ id: aiOnCallIncidents.id }).from(aiOnCallIncidents),
      db.select().from(playerAiIncidentAttempts).where(eq(playerAiIncidentAttempts.playerId, playerId)),
      db.select({ id: aiInterviewQuestions.id }).from(aiInterviewQuestions),
      db.select().from(playerAiInterviewAttempts).where(eq(playerAiInterviewAttempts.playerId, playerId)),
    ]);
    const attemptedIncidents = new Set(incidentAttempts.map((row) => row.incidentId));
    const attemptedQuestions = new Set(interviewAttempts.map((row) => row.questionId));
    return {
      incidents: {
        total: incidents.length,
        attempted: attemptedIncidents.size,
        bestScore: incidentAttempts.length ? Math.max(...incidentAttempts.map((row) => row.score)) : null,
      },
      interviews: {
        total: questions.length,
        attempted: attemptedQuestions.size,
        bestScore: interviewAttempts.length ? Math.max(...interviewAttempts.map((row) => row.score)) : null,
      },
    };
  }

  async listIncidents(playerId: string): Promise<AiIncidentSummary[]> {
    const [rows, attempts] = await Promise.all([
      db.select().from(aiOnCallIncidents).orderBy(aiOnCallIncidents.order),
      db.select().from(playerAiIncidentAttempts).where(eq(playerAiIncidentAttempts.playerId, playerId)),
    ]);
    return rows.map((row) => {
      const own = attempts.filter((attempt) => attempt.incidentId === row.id);
      return {
        id: row.id,
        slug: row.slug,
        title: row.title,
        symptom: row.symptom,
        difficulty: row.difficulty as AiIncidentSummary["difficulty"],
        attemptCount: own.length,
        bestScore: own.length ? Math.max(...own.map((attempt) => attempt.score)) : null,
      };
    });
  }

  async getIncident(slug: string, playerId: string): Promise<AiIncidentDetail> {
    const [incident] = await db.select().from(aiOnCallIncidents).where(eq(aiOnCallIncidents.slug, slug)).limit(1);
    if (!incident) throw new NotFoundException("AI incident not found");
    const attempts = await db
      .select()
      .from(playerAiIncidentAttempts)
      .where(and(eq(playerAiIncidentAttempts.playerId, playerId), eq(playerAiIncidentAttempts.incidentId, incident.id)))
      .orderBy(desc(playerAiIncidentAttempts.createdAt));
    return {
      id: incident.id,
      slug: incident.slug,
      title: incident.title,
      symptom: incident.symptom,
      difficulty: incident.difficulty as AiIncidentSummary["difficulty"],
      evidence: evidence(incident.evidence),
      attemptCount: attempts.length,
      bestScore: attempts.length ? Math.max(...attempts.map((attempt) => attempt.score)) : null,
      latestAttempt: attempts[0] ? incidentAttemptDto(attempts[0]) : null,
    };
  }

  async submitIncident(slug: string, playerId: string, body: { diagnosis?: string; mitigation?: string }) {
    const [incident] = await db.select().from(aiOnCallIncidents).where(eq(aiOnCallIncidents.slug, slug)).limit(1);
    if (!incident) throw new NotFoundException("AI incident not found");
    const diagnosis = body.diagnosis?.trim() ?? "";
    const mitigation = body.mitigation?.trim() ?? "";
    if (diagnosis.length < 40) throw new BadRequestException("Diagnosis must contain at least 40 characters");
    if (mitigation.length < 40) throw new BadRequestException("Mitigation must contain at least 40 characters");
    const signals = strings(incident.expectedSignals);
    const { matched, score } = scoreResponse(`${diagnosis}\n${mitigation}`, signals);
    const missing = signals.filter((signal) => !matched.includes(signal));
    const feedback = [
      matched.length
        ? `Strong signals: ${matched.join(", ")}.`
        : "The response does not yet name a diagnostic signal from the incident trace.",
      missing.length
        ? `Strengthen the response by connecting these signals to evidence and rollback: ${missing.slice(0, 4).join(", ")}.`
        : "The response covers every expected signal; tighten the order of containment, diagnosis and recovery.",
      `Reference resolution: ${incident.resolution}`,
    ];
    const [saved] = await db.insert(playerAiIncidentAttempts).values({
      playerId,
      incidentId: incident.id,
      diagnosis,
      mitigation,
      score,
      feedback,
    }).returning();
    return incidentAttemptDto(saved!);
  }

  async listInterviewQuestions(playerId: string): Promise<AiInterviewQuestion[]> {
    const [questions, attempts] = await Promise.all([
      db.select().from(aiInterviewQuestions).orderBy(aiInterviewQuestions.order),
      db.select().from(playerAiInterviewAttempts).where(eq(playerAiInterviewAttempts.playerId, playerId)),
    ]);
    return questions.map((question) => {
      const own = attempts
        .filter((attempt) => attempt.questionId === question.id)
        .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());
      return {
        id: question.id,
        question: question.question,
        focus: question.focus,
        attemptCount: own.length,
        bestScore: own.length ? Math.max(...own.map((attempt) => attempt.score)) : null,
        latestAttempt: own[0] ? interviewAttemptDto(own[0]) : null,
      };
    });
  }

  async submitInterview(questionId: string, playerId: string, body: { answer?: string }) {
    const [question] = await db.select().from(aiInterviewQuestions).where(eq(aiInterviewQuestions.id, questionId)).limit(1);
    if (!question) throw new NotFoundException("AI interview question not found");
    const answer = body.answer?.trim() ?? "";
    if (answer.length < 80) throw new BadRequestException("Answer must contain at least 80 characters");
    const signals = strings(question.expectedSignals);
    const { matched, score } = scoreResponse(answer, signals);
    const missing = signals.filter((signal) => !matched.includes(signal));
    const feedback = [
      matched.length ? `Covered: ${matched.join(", ")}.` : "Start with a direct definition before adding examples.",
      missing.length
        ? `Still address: ${missing.join(", ")}. Connect each term to a tradeoff or failure mode.`
        : "Every expected signal is present. Make the answer more concise and add one concrete example.",
    ];
    const [saved] = await db.insert(playerAiInterviewAttempts).values({
      playerId,
      questionId,
      answer,
      score,
      matchedSignals: matched,
      feedback,
    }).returning();
    return interviewAttemptDto(saved!);
  }
}
