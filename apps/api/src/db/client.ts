import postgres from "postgres";
import { drizzle } from "drizzle-orm/postgres-js";
import * as schema from "./schema";

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error("DATABASE_URL is not set — copy apps/api/.env.example to .env");
}

const queryClient = postgres(connectionString);

export const db = drizzle(queryClient, { schema });
