import postgres from "postgres";
import { drizzle } from "drizzle-orm/postgres-js";
import * as schema from "./schema";

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error("DATABASE_URL is not set — copy apps/api/.env.example to .env");
}

// prepare: false — not required for the session pooler this process
// actually uses (Render runs a long-lived `node dist/main.js` like local
// dev), but kept so switching to a transaction-mode pooler later is a
// config change, not a code change.
const queryClient = postgres(connectionString, { prepare: false });

export const db = drizzle(queryClient, { schema });
