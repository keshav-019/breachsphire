# Breachsphire

A story-driven learning game for engineers. Players join Nexus, a futuristic
operations organization, get sent on missions, investigate incidents, and earn
clearance, XP and credits instead of watching lectures and taking quizzes.

Five independent pathways, each a full campaign with its own Acts and missions:

| Pathway | Track | Scope |
| --- | --- | --- |
| **Cyber Guardians** | Cybersecurity | 74 worlds across 11 Acts, from a first phishing recovery to containing an autonomous AI adversary |
| **The Fracture** | Backend engineering | Building, securing, scaling and operating the systems a digital city depends on |
| **Cipher Division** | AI / ML | From a first model to production AI: classical ML, deep learning, NLP, transformers, LLMs, RAG and agents |
| **Vector Division** | Robotics, embedded & IoT | Electronics, firmware, RTOS, sensors, control, ROS 2, SLAM and safety-critical design |
| **Atlas Division** | Cloud, DevOps & SRE | From one Linux host to multi-region infrastructure: Docker, Terraform, Kubernetes, observability, incident response, DR |

Full design and architecture reference: **[docs/](./docs/README.md)**.

**Play it:** [breachsphire.yourwaytolearn.com](https://breachsphire.yourwaytolearn.com)

| Command center | Pathway selection |
| --- | --- |
| ![Breachsphire command center](docs/screenshots/command.jpg) | ![Breachsphire pathways](docs/screenshots/pathways.jpg) |

| Mission briefing | Mission challenge |
| --- | --- |
| ![Breachsphire mission briefing with mentor Ava](docs/screenshots/mission-briefing.jpg) | ![Breachsphire mission challenge](docs/screenshots/mission-challenge.jpg) |

| Campaign missions | World map |
| --- | --- |
| ![Breachsphire campaign mission list](docs/screenshots/campaign.jpg) | ![Breachsphire world map](docs/screenshots/world-map.jpg) |

## Quickstart

Production runs on one VM (`vanisher.projectyourown.com`): PostgreSQL and the
NestJS API (which also handles auth) in Docker Compose, deployed by GitHub
Actions on every push to `main`. See [Deployment](./docs/13-deployment.md).

```bash
pnpm install
```

**Frontend only, against the VM's API** — put
`VITE_API_BASE_URL=http://vanisher.projectyourown.com:3001` in
`apps/web/.env`, then `pnpm dev:web` → http://localhost:5173.

**Full stack locally** (needs Docker) — a throwaway Postgres built from the
same migrations as production:

```bash
docker run -d --name breachsphire-dev -p 127.0.0.1:5432:5432 \
  -e POSTGRES_USER=breachsphire -e POSTGRES_PASSWORD=dev -e POSTGRES_DB=breachsphire postgres:18
until docker exec breachsphire-dev pg_isready -q; do sleep 1; done
PG_CONTAINER=breachsphire-dev DB_USER=breachsphire deploy/scripts/migrate.sh
```

Copy `apps/api/.env.example` → `apps/api/.env` with
`DATABASE_URL=postgres://breachsphire:dev@localhost:5432/breachsphire` and a
`JWT_SECRET`, leave `VITE_API_BASE_URL` empty (the Vite dev server proxies
`/api` to the local API), then `pnpm dev`:

- `apps/web` — http://localhost:5173
- `apps/api` — http://localhost:3001 (`/health`)

### Desktop

```bash
pnpm dev:desktop      # local web + API + Electron shell
pnpm build:desktop    # unpacked app in apps/desktop/dist/win-unpacked
pnpm dist:desktop     # Windows installer in apps/desktop/dist
```

The packaged app uses the same accounts and the same API on the VM as the web
application, so progress remains synchronized. See
[Forge Lab & desktop architecture](./docs/14-backend-forge-lab.md).

## Current implementation

The authenticated Cybersecurity and 32-Act Backend Engineering pathways are
implemented against the API and PostgreSQL. Forge Lab adds 12 system-design
briefs, five portfolio campaigns, and Java/Spring, Python/FastAPI, and Go
specializations with persisted progress. The Electron shell packages the same
experience for Windows.

## Testing

`apps/web` has a Playwright e2e suite that runs against the real dev servers,
API and database (no mocks) — auth (login/logout/session persistence/protected
routes), signup, and the World Map's live data. Point it at the local stack:
signup creates real accounts in whichever database the API uses.

It logs in as a **persistent test account** rather than creating a throwaway
user per run: copy `apps/web/.env.test.example` to `apps/web/.env.test` and
fill in that account's credentials (ask a teammate, or sign up your own test
account and use it — its World Map state is expected to stay untouched,
since nothing yet writes to `player_world_progress` after signup).

```bash
pnpm dev                      # dev servers must be running (or let Playwright start them)
cd apps/web
pnpm test:e2e                 # headless
pnpm test:e2e:ui              # interactive UI mode
```

## Status

The mission engine, pathway selection, progression data, Forge Lab, and
desktop shell are implemented. Remaining roadmap work includes real sandboxed
labs, richer achievements/leaderboards, content administration, publisher
signing, and a hosted desktop-download surface. See
[Development Phases & MVP Scope](./docs/09-development-phases.md).

## Repo layout

```
apps/       web (player frontend) · api (NestJS backend) · admin (Mission Builder, placeholder)
packages/   types (shared schema) · ui · game-engine · mission-engine · config · labs (placeholders)
infra/      migrations (database schema + game content)
deploy/     VM Docker Compose stack + deploy scripts
.github/    CI/CD (typecheck, image build, deploy to the VM)
docs/       design & architecture wiki
```

Details: [docs/08-repo-structure.md](./docs/08-repo-structure.md).
