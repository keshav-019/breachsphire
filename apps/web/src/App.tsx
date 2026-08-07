import { useEffect } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AppShell } from "./components/guardians/AppShell";
import { RequireAuth } from "./components/auth/RequireAuth";
import { useAuthStore } from "./store/auth";
import CommandPage from "./pages/CommandPage";
import MapPage from "./pages/MapPage";
import MissionPage from "./pages/MissionPage";
import ProfilePage from "./pages/ProfilePage";
import LeaderboardPage from "./pages/LeaderboardPage";
import AchievementsPage from "./pages/AchievementsPage";
import LoginPage from "./pages/LoginPage";
import SignupPage from "./pages/SignupPage";

export default function App() {
  const init = useAuthStore((s) => s.init);

  useEffect(() => {
    init();
  }, [init]);

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route
          path="/*"
          element={
            <RequireAuth>
              <AppShell>
                <Routes>
                  <Route path="/" element={<CommandPage />} />
                  <Route path="/map" element={<MapPage />} />
                  <Route path="/mission" element={<MissionPage />} />
                  <Route path="/profile" element={<ProfilePage />} />
                  <Route path="/leaderboard" element={<LeaderboardPage />} />
                  <Route path="/achievements" element={<AchievementsPage />} />
                </Routes>
              </AppShell>
            </RequireAuth>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}
