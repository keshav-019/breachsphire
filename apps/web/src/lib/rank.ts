import { PLAYER_RANKS, type PlayerRank } from "@cyber-guardians/types";

const TITLES: Record<PlayerRank, string> = {
  civilian: "Civilian",
  recruit: "Recruit",
  cadet: "Cadet",
  analyst: "Analyst",
  operator: "Operator",
  pentester: "Pentester",
  hunter: "Hunter",
  specialist: "Specialist",
  commander: "Commander",
  elite_guardian: "Elite Guardian",
};

const CLEARANCE = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];

export function rankDisplay(rank: string): { title: string; clearance: string } {
  const index = PLAYER_RANKS.indexOf(rank as PlayerRank);
  const safeIndex = index === -1 ? 0 : index;
  return { title: TITLES[PLAYER_RANKS[safeIndex]], clearance: CLEARANCE[safeIndex] };
}
