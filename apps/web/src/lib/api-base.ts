// VITE_API_BASE_URL points the app at the API directly (see .env.example).
// Left empty, browser builds go through the /api reverse proxy (Vite dev
// server locally, vercel.json rewrites in production).
const apiBase = (
  import.meta.env.VITE_API_BASE_URL ||
  (window.location.protocol === "file:" ? "http://vanisher.projectyourown.com:3001" : "/api")
).replace(/\/$/, "");

export function apiUrl(path: string) {
  return `${apiBase}${path.startsWith("/") ? path : `/${path}`}`;
}
