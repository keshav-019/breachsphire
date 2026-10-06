# NestJS API image. Build from the repo root so the pnpm workspace and
# lockfile are available:
#
#   docker build -f apps/api/Dockerfile -t breachsphire-api .

# ---- build ------------------------------------------------------------------
FROM node:22-alpine AS build
WORKDIR /repo
RUN corepack enable

# Manifests first so dependency install is cached across source changes.
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc tsconfig.base.json ./
COPY apps/api/package.json apps/api/
COPY packages/types/package.json packages/types/
RUN pnpm install --frozen-lockfile --filter @cyber-guardians/api...

COPY packages/types packages/types
COPY apps/api apps/api
RUN pnpm --filter @cyber-guardians/api build \
 && pnpm --filter @cyber-guardians/api deploy --prod --legacy /out \
 && cp -r apps/api/dist /out/dist

# ---- runtime ----------------------------------------------------------------
FROM node:22-alpine
ENV NODE_ENV=production PORT=3001
WORKDIR /app
COPY --from=build --chown=node:node /out ./
USER node
EXPOSE 3001
HEALTHCHECK --interval=15s --timeout=5s --start-period=20s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:'+process.env.PORT+'/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"
CMD ["node", "dist/main.js"]
