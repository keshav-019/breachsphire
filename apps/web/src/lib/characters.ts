import avaAvatar from "@/assets/characters/ava.webp";
import byteAvatar from "@/assets/characters/byte.webp";
import lunaAvatar from "@/assets/characters/luna.webp";
import zaynAvatar from "@/assets/characters/zayn.webp";

export type CharacterProfile = {
  name: string;
  role: string;
  avatarUrl?: string;
};

const CHARACTER_PROFILES: Record<string, CharacterProfile> = {
  ava: { name: "Ava", role: "Cyber Guardian Mentor", avatarUrl: avaAvatar },
  byte: { name: "Byte", role: "AI Companion", avatarUrl: byteAvatar },
  zayn: { name: "Zayn", role: "Network Specialist", avatarUrl: zaynAvatar },
  luna: { name: "Luna", role: "Strategist", avatarUrl: lunaAvatar },
  cipher: { name: "Cipher", role: "Unknown" },
  sentinel_x: { name: "Sentinel-X", role: "???" },
  system: { name: "System", role: "Automated" },
  mira: { name: "Mira Voss", role: "Chief Architect" },
  forge: { name: "Forge", role: "Ops Assistant AI" },
  fracture: { name: "The Fracture", role: "???" },
  maya: { name: "Dr. Maya Sen", role: "Director, Cipher Division" },
  arjun: { name: "Arjun Vale", role: "Data Engineer" },
  elena: { name: "Dr. Elena Rook", role: "Research Scientist" },
  noah: { name: "Noah Kim", role: "ML Platform Engineer" },
  echo: { name: "Echo", role: "???" },
};

export function getCharacterProfile(characterId: string): CharacterProfile {
  return CHARACTER_PROFILES[characterId] ?? { name: characterId, role: "" };
}
