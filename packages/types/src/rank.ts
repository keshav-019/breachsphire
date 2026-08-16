/**
 * The clearance progression from the World Story & Campaign Bible
 * (docs/12-world-story-bible.md §2.1). Clearance is a story wrapper around
 * prerequisite mastery: a player can revisit any unlocked World, but new
 * operational privileges (real Docker labs, advanced AD ranges, exploit
 * research, command simulations) unlock only after the required skills and
 * safety briefings are complete.
 */
export const PLAYER_RANKS = [
  "civilian",
  "recruit",
  "cadet",
  "analyst",
  "operator",
  "pentester",
  "hunter",
  "specialist",
  "commander",
  "elite_guardian",
] as const;

export type PlayerRank = (typeof PLAYER_RANKS)[number];

export const SKILL_TRACKS = [
  "networking",
  "linux",
  "windows",
  "web_security",
  "programming",
  "pentesting",
  "soc",
  "incident_response",
  "forensics",
  "malware_analysis",
  "cloud_security",
  "cryptography",
  "threat_hunting",
  "ai_security",
  "backend_fundamentals",
  "api_design",
  "auth_and_identity",
  "software_architecture",
  "databases",
  "realtime_systems",
  "caching",
  "messaging",
  "backend_security",
  "file_storage",
  "testing",
  "performance_and_scale",
  "resilience_engineering",
  "observability",
  "search_systems",
  "deployment_and_cloud",
  "kubernetes",
  "distributed_systems",
  "messaging_mastery",
  "graphql_mastery",
  "database_internals",
  "system_design",
  "portfolio_engineering",
  "interview_readiness",
  "ai_ml_fundamentals",
  "python_for_ml",
  "ml_mathematics",
  "probability_statistics",
  "data_engineering_ml",
  "regression",
  "classification",
  "classical_ml",
  "unsupervised_learning",
  "feature_engineering",
  "deep_learning",
  "optimization",
  "pytorch",
  "tensorflow",
  "ml_experimentation",
  "computer_vision",
  "nlp",
  "representation_learning",
  "transformers",
  "llm_engineering",
  "vector_search",
  "rag",
  "agentic_ai",
  "langgraph_mcp",
  "multi_agent_systems",
  "ai_safety_evaluation",
  "mlops",
  "responsible_ai",
  "robotics_fundamentals",
  "cloud_devops_fundamentals",
] as const;

export type SkillTrack = (typeof SKILL_TRACKS)[number];

export interface PlayerSkill {
  track: SkillTrack;
  level: number;
  xp: number;
  xpToNextLevel: number;
}
