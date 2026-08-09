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
};

export function getCharacterProfile(characterId: string): CharacterProfile {
  return CHARACTER_PROFILES[characterId] ?? { name: characterId, role: "" };
}
