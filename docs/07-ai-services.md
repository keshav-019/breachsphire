# AI Services

These are the AI providers selected for Cyber Guardians, chosen to keep MVP
cost at effectively zero by leaning on free tiers and local/open models.
**None of these are wired into `apps/api` or `apps/web` yet** — this is the
target architecture, to be implemented module-by-module as the corresponding
feature is built (mission generation lands with the Mission Builder in
Phase 6, the AI mentor lands with Byte's dialogue system in Phase 3, etc.).

| Requirement | AI / service | Cost for MVP |
|---|---|---|
| Mission generation | Gemini 3.5 Flash / Flash-Lite | Free tier |
| Powerful alternative LLM | Groq + Llama/Qwen/GPT-OSS | Free tier |
| Fast NPC responses | Groq | Free tier |
| AI Mentor / Byte | Gemini/Groq | Free tier |
| RAG | Cloudflare Vectorize | Free tier |
| Embeddings | Gemini Embedding 2 | Free tier |
| Character/background art | FLUX.1 Schnell | Free/local |
| AI image API | Cloudflare FLUX.1 Schnell | Free allocation |
| Character voices | Kokoro-82M | Free/local |
| Speech recognition | Groq Whisper | Free tier |
| Backup STT | Cloudflare Whisper | Free allocation |
| Prompt safety | Groq Prompt Guard | Free tier |
| Content safety | Cloudflare Llama Guard | Free allocation |
| Development coding | GitHub Copilot Free | Free |
| Model experimentation | GitHub Models | Free |
| Extra LLM fallback | OpenRouter Free Models | Free |
| Prototyping voices | ElevenLabs Free | Free, not for commercial use |
| Local models | Ollama + open models | Free |

## Where each one plugs in

- **Mission generation / AI mentor (Byte) / NPC responses** — these are the
  ones that touch `apps/api`. They belong behind a small provider-agnostic
  interface in a future `packages/ai` (or inside `apps/api`'s relevant
  module) so swapping Gemini for Groq, or adding OpenRouter as a fallback,
  doesn't ripple through calling code.
- **RAG / embeddings** — supports lore-consistent AI mentor answers and,
  later, semantic search over mission content; depends on Worlds/Campaigns/
  Missions data existing first (Phase 2), so this is a Phase 3+ concern.
- **Image/voice generation** — asset pipeline, feeds into Cloudflare R2
  storage (see [Architecture & Tech Stack](./06-architecture-tech-stack.md)),
  not a runtime dependency of the app itself.
- **Prompt/content safety (Prompt Guard, Llama Guard)** — sits in front of
  any user input reaching an LLM (chat with Byte, mission-generation prompts
  from admins) once those features exist.
- **Coding assistance (Copilot Free, GitHub Models, Ollama)** — developer
  tooling for building Cyber Guardians itself, not a runtime dependency of
  the shipped product.

## Cross-provider principle

Every LLM-backed feature should be written against a small abstraction
(prompt in, text/JSON out) rather than a specific SDK, since the plan
explicitly keeps Gemini, Groq, and OpenRouter interchangeable as fallbacks.
Pin this down when Phase 3 (dialogue engine) starts, since that's the first
feature that actually calls one of these.
