import { Suspense, lazy, useEffect } from "react";
import { BrowserRouter, HashRouter, Routes, Route, Navigate, useLocation } from "react-router-dom";
import { AppShell } from "./components/guardians/AppShell";
import { RequireAuth } from "./components/auth/RequireAuth";
import { useAuthStore } from "./store/auth";
import { usePathwayStore } from "./store/pathway";

// Route-level code splitting: each page (and everything it alone pulls in —
// e.g. MissionPage's challenge renderers, including xterm.js for terminal
// challenges) ships as its own chunk instead of one large bundle everyone
// downloads regardless of which page they land on.
const PathwaySelectPage = lazy(() => import("./pages/PathwaySelectPage"));
const CommandPage = lazy(() => import("./pages/CommandPage"));
const MapPage = lazy(() => import("./pages/MapPage"));
const WorldMissionsPage = lazy(() => import("./pages/WorldMissionsPage"));
const MissionPage = lazy(() => import("./pages/MissionPage"));
const ProfilePage = lazy(() => import("./pages/ProfilePage"));
const LeaderboardPage = lazy(() => import("./pages/LeaderboardPage"));
const AchievementsPage = lazy(() => import("./pages/AchievementsPage"));
const ForgeLabPage = lazy(() => import("./pages/ForgeLabPage"));
const SystemDesignArenaPage = lazy(() => import("./pages/SystemDesignArenaPage"));
const SystemDesignChallengePage = lazy(() => import("./pages/SystemDesignChallengePage"));
const PortfolioCampaignsPage = lazy(() => import("./pages/PortfolioCampaignsPage"));
const PortfolioCampaignPage = lazy(() => import("./pages/PortfolioCampaignPage"));
const LanguageTracksPage = lazy(() => import("./pages/LanguageTracksPage"));
const LanguageTrackPage = lazy(() => import("./pages/LanguageTrackPage"));
const AiIncidentsPage = lazy(() => import("./pages/AiIncidentsPage"));
const AiIncidentPage = lazy(() => import("./pages/AiIncidentPage"));
const AiInterviewArenaPage = lazy(() => import("./pages/AiInterviewArenaPage"));
const LoginPage = lazy(() => import("./pages/LoginPage"));
const SignupPage = lazy(() => import("./pages/SignupPage"));

function RouteFallback() {
  return (
    <div className="px-5 py-8">
      <span className="label-mono flicker">Loading…</span>
    </div>
  );
}

/** Redirects to the pathway picker until the player has one selected. */
function RequirePathway({ children }: { children: React.ReactNode }) {
  const selectedPathwayId = usePathwayStore((s) => s.selectedPathwayId);
  if (!selectedPathwayId) {
    return <Navigate to="/pathways" replace />;
  }
  return <>{children}</>;
}

function RequireLabPathway({ children }: { children: React.ReactNode }) {
  const selectedPathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  if (selectedPathwaySlug !== "backend-engineering" && selectedPathwaySlug !== "ai-ml") {
    return <Navigate to="/pathways" replace />;
  }
  return <>{children}</>;
}

function RequireAiPathway({ children }: { children: React.ReactNode }) {
  const selectedPathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  if (selectedPathwaySlug !== "ai-ml") {
    return <Navigate to="/pathways" replace />;
  }
  return <>{children}</>;
}

function ScrollToTop() {
  const { pathname } = useLocation();
  useEffect(() => {
    window.scrollTo({ top: 0, left: 0 });
  }, [pathname]);
  return null;
}

export default function App() {
  const init = useAuthStore((s) => s.init);
  const isDesktop = window.location.protocol === "file:";
  const Router = isDesktop ? HashRouter : BrowserRouter;

  useEffect(() => {
    init();
  }, [init]);

  return (
    <Router>
      <ScrollToTop />
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
                      <Route path="/pathways" element={<PathwaySelectPage />} />
                      {/* Command and World Map no longer hard-redirect when no
                          pathway is selected -- each renders its own in-page
                          picker (see NoPathwaySelected in each file) so landing
                          here directly never looks like an empty, redirecting
                          page. RequirePathway still guards /worlds/:worldId,
                          which has no meaningful standalone content. */}
                      <Route path="/" element={<CommandPage />} />
                      <Route path="/map" element={<MapPage />} />
                      <Route
                        path="/worlds/:worldId"
                        element={
                          <RequirePathway>
                            <WorldMissionsPage />
                          </RequirePathway>
                        }
                      />
                      <Route path="/mission/:missionId" element={<MissionPage />} />
                      <Route path="/profile" element={<ProfilePage />} />
                      <Route path="/leaderboard" element={<LeaderboardPage />} />
                      <Route path="/achievements" element={<AchievementsPage />} />
                      <Route path="/forge" element={<RequireLabPathway><ForgeLabPage /></RequireLabPathway>} />
                      <Route path="/forge/arena" element={<RequireLabPathway><SystemDesignArenaPage /></RequireLabPathway>} />
                      <Route path="/forge/arena/:slug" element={<RequireLabPathway><SystemDesignChallengePage /></RequireLabPathway>} />
                      <Route path="/forge/portfolio" element={<RequireLabPathway><PortfolioCampaignsPage /></RequireLabPathway>} />
                      <Route path="/forge/portfolio/:slug" element={<RequireLabPathway><PortfolioCampaignPage /></RequireLabPathway>} />
                      <Route path="/forge/tracks" element={<RequireLabPathway><LanguageTracksPage /></RequireLabPathway>} />
                      <Route path="/forge/tracks/:slug" element={<RequireLabPathway><LanguageTrackPage /></RequireLabPathway>} />
                      <Route path="/forge/incidents" element={<RequireAiPathway><AiIncidentsPage /></RequireAiPathway>} />
                      <Route path="/forge/incidents/:slug" element={<RequireAiPathway><AiIncidentPage /></RequireAiPathway>} />
                      <Route path="/forge/interviews" element={<RequireAiPathway><AiInterviewArenaPage /></RequireAiPathway>} />
                    </Routes>
                  </Suspense>
                </AppShell>
              </RequireAuth>
            }
          />
        </Routes>
      </Suspense>
    </Router>
  );
}
