import postgres from "postgres";
import { drizzle } from "drizzle-orm/postgres-js";
import * as schema from "./schema";

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error("DATABASE_URL is not set — copy apps/api/.env.example to .env");
}

// prepare: false — required for Supabase's transaction-mode pooler
// (port 6543), which Vercel's serverless deployment uses since each
// invocation can't hold a dedicated session the way the local long-running
// `nest start` process does. Harmless against the session pooler too.
const queryClient = postgres(connectionString, { prepare: false });

export const db = drizzle(queryClient, { schema });
