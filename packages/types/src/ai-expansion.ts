export interface AiIncidentEvidence {
  label: string;
  detail: string;
}

export interface AiIncidentSummary {
  id: string;
  slug: string;
  title: string;
  symptom: string;
  difficulty: "foundation" | "intermediate" | "advanced" | "critical";
  bestScore: number | null;
  attemptCount: number;
}

export interface AiIncidentDetail extends AiIncidentSummary {
  evidence: AiIncidentEvidence[];
  latestAttempt: AiIncidentAttempt | null;
}

export interface AiIncidentAttempt {
  id: string;
  diagnosis: string;
  mitigation: string;
  score: number;
  feedback: string[];
  createdAt: string;
}

export interface AiInterviewQuestion {
  id: string;
  question: string;
  focus: string;
  bestScore: number | null;
  attemptCount: number;
  latestAttempt: AiInterviewAttempt | null;
}

export interface AiInterviewAttempt {
  id: string;
  answer: string;
  score: number;
  matchedSignals: string[];
  feedback: string[];
  createdAt: string;
}

export interface AiPracticeOverview {
  incidents: { total: number; attempted: number; bestScore: number | null };
  interviews: { total: number; attempted: number; bestScore: number | null };
}
