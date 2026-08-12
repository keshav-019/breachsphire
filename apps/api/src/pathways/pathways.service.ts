import { Injectable } from "@nestjs/common";
import { and, eq } from "drizzle-orm";
import { db } from "../db/client";
import { pathways, worlds, playerWorldProgress } from "../db/schema";

export interface PathwayDto {
  id: string;
  slug: string;
  title: string;
  tagline: string;
  description: string;
  icon: string;
  actsTotal: number;
  actsCleared: number;
  started: boolean;
}

@Injectable()
export class PathwaysService {
  async listForPlayer(playerId: string): Promise<PathwayDto[]> {
    const pathwayRows = await db.select().from(pathways).orderBy(pathways.sortOrder);

    const worldRows = await db
      .select({
        pathwayId: worlds.pathwayId,
        state: playerWorldProgress.state,
      })
      .from(worlds)
      .leftJoin(
        playerWorldProgress,
        and(eq(playerWorldProgress.worldId, worlds.id), eq(playerWorldProgress.playerId, playerId)),
      );

    return pathwayRows.map((p) => {
      const rows = worldRows.filter((w) => w.pathwayId === p.id);
      const cleared = rows.filter((w) => w.state === "cleared").length;
      // Every pathway grants its first world as `unlocked`, including for a
      // brand-new player. That is availability, not evidence that the player
      // already started the campaign.
      const started = rows.some((w) => w.state === "cleared" || w.state === "active");
      return {
        id: p.id,
        slug: p.slug,
        title: p.title,
        tagline: p.tagline,
        description: p.description,
        icon: p.icon,
        actsTotal: rows.length,
        actsCleared: cleared,
        started,
      };
    });
  }
}
