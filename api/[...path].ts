import "reflect-metadata";
import type { IncomingMessage, ServerResponse } from "node:http";
import express, { type Express } from "express";
import { NestFactory } from "@nestjs/core";
import { ExpressAdapter } from "@nestjs/platform-express";
import { AppModule } from "../apps/api/src/app.module";

/**
 * Vercel entrypoint for the NestJS API (section "make it Vercel
 * compatible"). Wraps the same AppModule the local `nest start` process
 * boots, on an Express instance handed to Vercel's Node.js runtime
 * directly as a (req, res) handler. `cachedApp` persists across warm
 * invocations of the same function instance, so Nest only bootstraps once
 * per cold start, not per request.
 */
let cachedApp: Express | null = null;

async function getApp(): Promise<Express> {
  if (cachedApp) return cachedApp;

  const expressInstance = express();
  const nestApp = await NestFactory.create(AppModule, new ExpressAdapter(expressInstance), {
    logger: ["error", "warn"],
  });
  nestApp.enableCors();
  await nestApp.init();

  cachedApp = expressInstance;
  return expressInstance;
}

export default async function handler(req: IncomingMessage, res: ServerResponse) {
  const app = await getApp();

  // Nest's controllers are registered without an /api prefix (e.g. `/health`,
  // `/worlds`) — this mirrors the Vite dev-server proxy's rewrite
  // (apps/web/vite.config.ts) that strips `/api` before forwarding to
  // localhost:3001. Vercel routes every `/api/*` request to this function
  // with the prefix intact, so strip it here the same way.
  if (req.url) {
    req.url = req.url.replace(/^\/api/, "") || "/";
  }

  app(req, res);
}
