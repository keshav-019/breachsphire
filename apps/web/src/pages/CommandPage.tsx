import { MissionBriefing } from "@/components/guardians/MissionBriefing";
import { OperationPath } from "@/components/guardians/OperationPath";
import { SkillMatrix } from "@/components/guardians/SkillMatrix";
import { SquadOps } from "@/components/guardians/SquadOps";

export default function CommandPage() {
  return (
    <div>
      <main>
        <MissionBriefing />
        <OperationPath />
        <SkillMatrix />
        <SquadOps />
      </main>
      <footer className="border-t border-border py-8">
        <div className="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-3 px-5">
          <span className="label-mono">Cyber Guardians · Ops Division · Node 07</span>
          <span className="label-mono text-telemetry">All systems nominal</span>
        </div>
      </footer>
    </div>
  );
}
