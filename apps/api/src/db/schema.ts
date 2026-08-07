import { pgTable, text, integer, real, uuid, timestamp, primaryKey } from "drizzle-orm/pg-core";

/**
 * Mirrors infra/supabase/migrations/*_worlds.sql by hand — Drizzle is a
 * typed query layer here, not the migration source of truth.
 */

export const worlds = pgTable("worlds", {
  id: text("id").primaryKey(),
  index: integer("index").notNull(),
  name: text("name").notNull(),
  short: text("short").notNull(),
  icon: text("icon").notNull(),
  boss: text("boss"),
  threat: text("threat").notNull(),
  x: real("x").notNull(),
  y: real("y").notNull(),
});

export const playerWorldProgress = pgTable(
  "player_world_progress",
  {
    playerId: uuid("player_id").notNull(),
    worldId: text("world_id").notNull(),
    state: text("state").notNull().default("locked"),
    completion: integer("completion").notNull().default(0),
    updatedAt: timestamp("updated_at", { withTimezone: true }).notNull().defaultNow(),
  },
  (t) => [primaryKey({ columns: [t.playerId, t.worldId] })],
);
