import { create } from "zustand";
import { persist } from "zustand/middleware";

/**
 * Which top-level campaign track (Cyber Guardians, The Fracture, ...) the
 * player is currently in. Kept out of the URL -- world/mission ids are
 * already globally unique, so `/map`, `/worlds/:id` etc. stay flat and just
 * read whichever pathway is selected here (see docs in App.tsx's redirect
 * guard for why).
 */
interface PathwayState {
  selectedPathwayId: string | null;
  selectedPathwaySlug: string | null;
  selectedPathwayTitle: string | null;
  setPathway: (pathway: { id: string; slug: string; title: string }) => void;
  clear: () => void;
}

export const usePathwayStore = create<PathwayState>()(
  persist(
    (set) => ({
      selectedPathwayId: null,
      selectedPathwaySlug: null,
      selectedPathwayTitle: null,
      setPathway: (pathway) =>
        set({
          selectedPathwayId: pathway.id,
          selectedPathwaySlug: pathway.slug,
          selectedPathwayTitle: pathway.title,
        }),
      clear: () => set({ selectedPathwayId: null, selectedPathwaySlug: null, selectedPathwayTitle: null }),
    }),
    { name: "breachsphire-pathway" },
  ),
);
