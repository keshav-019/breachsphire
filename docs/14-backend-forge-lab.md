# Backend Engineering: Forge Lab

Forge Lab is the post-game layer for **The Fracture** backend-engineering
pathway. It is deliberately separate from the World -> Campaign -> Operation
-> Mission hierarchy because each station records a different kind of proof.

## Stations

### System Design Arena

- 12 freeform briefs: URL shortener, rate limiter, notifications, chat, news
  feed, file storage, payments, search, video processing, ride matching,
  metrics, and global commerce.
- Four variants per brief: Foundation, At Scale, Incident Inject, and
  Interview.
- Learners submit assumptions, architecture/request flows, and tradeoffs.
- A visible, deterministic rubric returns a practice signal and dimension-level
  feedback. It is a first-pass practice aid, not a replacement for human
  architectural review.

### Portfolio Campaigns

- Civic API
- Nexus Commerce
- Transit Realtime
- Forge Microservices
- Global Nexus

Each campaign contains five concrete milestones and stores repository/demo
links plus an engineering reflection. Source code stays in the learner's own
repository; Breachsphire stores only progress and evidence links.

### Language Specializations

- Java with Spring Boot
- Python with FastAPI
- Go with the standard library and chi

Each track has eight modules spanning language foundations, HTTP, persistence,
security/concurrency, messaging, testing, and production operation. Tracks are
independently enrollable and end in a deployable capstone.

## Implementation boundaries

- Migration: `infra/supabase/migrations/20260811010000_backend_expansion_systems.sql`
- API module: `apps/api/src/backend-expansion/`
- Web routes: `/forge`, `/forge/arena`, `/forge/portfolio`, `/forge/tracks`
- Shared contracts: `packages/types/src/backend-expansion.ts`

The migration removes the earlier placeholder Arena and Portfolio World nodes.
Messaging, GraphQL, and database mastery remain on the World Map because those
are structured lesson sequences. Field Ops remains a future content surface.

## Desktop application

The Electron shell lives in `apps/desktop`. It packages the same Vite renderer,
uses hash routing for `file:` URLs, connects to the deployed API by default,
and keeps the renderer sandboxed with Node integration disabled.

```bash
pnpm dev:desktop      # web + API + Electron development
pnpm build:desktop    # unpacked Windows application
pnpm dist:desktop     # Windows NSIS installer
```

Release artifacts are written to `apps/desktop/dist/`. Before publishing a
download, add product icons and code-sign the installer in the release
pipeline; the current local build is suitable for functional testing but is
not signed by a trusted publisher certificate.
