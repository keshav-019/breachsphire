import { Suspense, lazy, useEffect } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AppShell } from "./components/guardians/AppShell";
import { RequireAuth } from "./components/auth/RequireAuth";
import { useAuthStore } from "./store/auth";

// Route-level code splitting: each page (and everything it alone pulls in —
// e.g. MissionPage's challenge renderers, including xterm.js for terminal
// challenges) ships as its own chunk instead of one large bundle everyone
// downloads regardless of which page they land on.
const CommandPage = lazy(() => import("./pages/CommandPage"));
const MapPage = lazy(() => import("./pages/MapPage"));
const WorldMissionsPage = lazy(() => import("./pages/WorldMissionsPage"));
const MissionPage = lazy(() => import("./pages/MissionPage"));
const ProfilePage = lazy(() => import("./pages/ProfilePage"));
const LeaderboardPage = lazy(() => import("./pages/LeaderboardPage"));
const AchievementsPage = lazy(() => import("./pages/AchievementsPage"));
const LoginPage = lazy(() => import("./pages/LoginPage"));
const SignupPage = lazy(() => import("./pages/SignupPage"));

function RouteFallback() {
  return (
    <div className="px-5 py-8">
      <span className="label-mono flicker">Loading…</span>
    </div>
  );
}

export default function App() {
  const init = useAuthStore((s) => s.init);

  useEffect(() => {
    init();
  }, [init]);

  return (
    <BrowserRouter>
      <Suspense fallback={<RouteFallback />}>
        <Routes>
          <Route path="/login" element={<LoginPage />} />
          <Route path="/signup" element={<SignupPage />} />
          <Route
            path="/*"
            element={
              <RequireAuth>
                <AppShell>
                  <Suspense fallback={<RouteFallback />}>
                    <Routes>
                      <Route path="/" element={<CommandPage />} />
                      <Route path="/map" element={<MapPage />} />
                      <Route path="/worlds/:worldId" element={<WorldMissionsPage />} />
                      <Route path="/mission/:missionId" element={<MissionPage />} />
                      <Route path="/profile" element={<ProfilePage />} />
                      <Route path="/leaderboard" element={<LeaderboardPage />} />
                      <Route path="/achievements" element={<AchievementsPage />} />
                    </Routes>
                  </Suspense>
                </AppShell>
              </RequireAuth>
            }
          />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}
