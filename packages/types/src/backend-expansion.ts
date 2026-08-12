export type ArenaMode = "foundation" | "scale" | "incident" | "interview";

export interface ArenaModeDefinition {
  id: ArenaMode;
  label: string;
  description: string;
  constraints: string[];
}

export interface ArenaRubricCriterion {
  key: string;
  label: string;
  description: string;
  weight: number;
  keywords: string[];
}

export interface ArenaCriterionScore {
  key: string;
  label: string;
  score: number;
  maxScore: number;
  matchedSignals: string[];
}

export interface ArenaSubmission {
  id: string;
  mode: ArenaMode;
  architecture: string;
  assumptions: string;
  tradeoffs: string;
  score: number;
  criterionScores: ArenaCriterionScore[];
  feedback: string[];
  createdAt: string;
}

export interface SystemDesignChallengeSummary {
  id: string;
  slug: string;
  title: string;
  domain: string;
  summary: string;
  estimatedMinutes: number;
  submissionCount: number;
  bestScore: number | null;
}

export interface SystemDesignChallengeDetail extends SystemDesignChallengeSummary {
  prompt: string;
  context: string;
  functionalRequirements: string[];
  nonfunctionalRequirements: string[];
  modes: ArenaModeDefinition[];
  rubric: ArenaRubricCriterion[];
  latestSubmission: ArenaSubmission | null;
}

export interface ArenaSubmissionInput {
  mode: ArenaMode;
  architecture: string;
  assumptions: string;
  tradeoffs: string;
}

export type PortfolioStatus = "not_started" | "in_progress" | "completed";

export interface PortfolioMilestone {
  id: string;
  title: string;
  description: string;
  deliverable: string;
  order: number;
  completed: boolean;
}

export interface PortfolioEvidence {
  repoUrl: string;
  liveUrl: string;
  reflection: string;
}

export interface PortfolioCampaignSummary {
  id: string;
  slug: string;
  title: string;
  tagline: string;
  summary: string;
  stackOptions: string[];
  status: PortfolioStatus;
  milestonesCompleted: number;
  milestonesTotal: number;
}

export interface PortfolioCampaignDetail extends PortfolioCampaignSummary {
  outcomes: string[];
  milestones: PortfolioMilestone[];
  evidence: PortfolioEvidence;
}

export type LanguageTrackStatus = "not_started" | "in_progress" | "completed";

export interface LanguageTrackModule {
  id: string;
  title: string;
  description: string;
  focus: string[];
  projectStep: string;
  order: number;
  completed: boolean;
  reflection: string;
}

export interface LanguageTrackSummary {
  id: string;
  slug: string;
  title: string;
  language: string;
  framework: string;
  description: string;
  icon: string;
  estimatedHours: number;
  status: LanguageTrackStatus;
  modulesCompleted: number;
  modulesTotal: number;
}

export interface LanguageTrackDetail extends LanguageTrackSummary {
  capstone: string;
  modules: LanguageTrackModule[];
}

export interface BackendExpansionOverview {
  arena: { completed: number; total: number; bestScore: number | null };
  portfolio: { completed: number; total: number; milestonesCompleted: number; milestonesTotal: number };
  tracks: { completed: number; enrolled: number; total: number; modulesCompleted: number; modulesTotal: number };
}
