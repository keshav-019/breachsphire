import { Injectable } from "@nestjs/common";
import { and, eq } from "drizzle-orm";
import { db } from "../db/client";
import { worlds, playerWorldProgress } from "../db/schema";

export interface WorldDto {
  id: string;
  index: number;
  name: string;
  short: string;
  icon: string;
  boss: string | null;
  threat: string;
  x: number;
  y: number;
  state: string;
  completion: number;
}

@Injectable()
export class WorldsService {
  async listForPlayer(playerId: string): Promise<WorldDto[]> {
    const rows = await db
      .select({
        id: worlds.id,
        index: worlds.index,
        name: worlds.name,
        short: worlds.short,
        icon: worlds.icon,
        boss: worlds.boss,
        threat: worlds.threat,
        x: worlds.x,
        y: worlds.y,
        state: playerWorldProgress.state,
        completion: playerWorldProgress.completion,
      })
      .from(worlds)
      .leftJoin(
        playerWorldProgress,
        and(eq(playerWorldProgress.worldId, worlds.id), eq(playerWorldProgress.playerId, playerId)),
      )
      .orderBy(worlds.index);

    return rows.map((row) => ({
      ...row,
      state: row.state ?? "locked",
      completion: row.completion ?? 0,
    }));
  }
}
