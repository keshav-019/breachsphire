import { Injectable, NotFoundException } from "@nestjs/common";
import { eq } from "drizzle-orm";
import { db } from "../db/client";
import { profiles } from "../db/schema";

export interface PlayerMeDto {
  id: string;
  email?: string;
  displayName: string;
  rank: string;
  xp: number;
  credits: number;
}

@Injectable()
export class PlayersService {
  async getMe(playerId: string, email: string | undefined): Promise<PlayerMeDto> {
    const [profile] = await db.select().from(profiles).where(eq(profiles.id, playerId));
    if (!profile) {
      throw new NotFoundException(`No profile for player ${playerId}`);
    }

    return {
      id: playerId,
      email,
      displayName: profile.displayName,
      rank: profile.rank,
      xp: profile.xp,
      credits: profile.credits,
    };
  }
}
