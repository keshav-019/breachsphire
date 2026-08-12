import { NavLink } from "react-router-dom";
import { Boxes, Code2, DraftingCompass, LayoutDashboard, MessagesSquare, Stethoscope } from "lucide-react";
import { usePathwayStore } from "@/store/pathway";

const BASE_ITEMS = [
  { to: "/forge", label: "Overview", icon: LayoutDashboard, end: true },
  { to: "/forge/arena", label: "Design Arena", icon: DraftingCompass },
  { to: "/forge/portfolio", label: "Portfolio", icon: Boxes },
];

export function ForgeNav() {
  const isAi = usePathwayStore((state) => state.selectedPathwaySlug === "ai-ml");
  const items = [
    ...BASE_ITEMS,
    { to: "/forge/tracks", label: isAi ? "Specialist Tracks" : "Language Tracks", icon: Code2 },
    ...(isAi ? [
      { to: "/forge/incidents", label: "On-Call", icon: Stethoscope },
      { to: "/forge/interviews", label: "Interview", icon: MessagesSquare },
    ] : []),
  ];
  return (
    <nav className="mt-6 grid grid-cols-2 gap-2 border-b border-border pb-3 sm:flex sm:overflow-x-auto" aria-label={isAi ? "Cipher Lab" : "Forge Lab"}>
      {items.map((item) => (
        <NavLink
          key={item.to}
          to={item.to}
          end={item.end}
          className={({ isActive }) =>
            `corner-cut flex shrink-0 items-center gap-2 px-3 py-2 font-mono text-[0.68rem] tracking-[0.13em] uppercase transition-colors ${
              isActive
                ? "bg-primary text-primary-foreground"
                : "border border-border bg-surface text-muted-foreground hover:text-foreground"
            }`
          }
        >
          <item.icon className="h-4 w-4" />
          {item.label}
        </NavLink>
      ))}
    </nav>
  );
}

export function ForgeHeader({
  eyebrow,
  title,
  description,
}: {
  eyebrow: string;
  title: string;
  description: string;
}) {
  const isAi = usePathwayStore((state) => state.selectedPathwaySlug === "ai-ml");
  return (
    <>
      <span className="label-mono text-primary">{isAi ? "Cipher Division" : "Forge Division"} // {eyebrow}</span>
      <h1 className="mt-2 text-3xl font-bold text-foreground sm:text-4xl">{title}</h1>
      <p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">{description}</p>
      <ForgeNav />
    </>
  );
}
