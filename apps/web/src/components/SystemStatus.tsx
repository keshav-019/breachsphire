import { useQuery } from "@tanstack/react-query";
import { fetchHealth } from "../lib/api";

export function SystemStatus() {
  const { data, error, isLoading } = useQuery({
    queryKey: ["health"],
    queryFn: fetchHealth,
    retry: 1,
    refetchInterval: 15000,
  });

  const state = isLoading ? "connecting" : error ? "offline" : data?.status ?? "unknown";

  const dot =
    state === "online"
      ? "bg-telemetry"
      : state === "connecting"
        ? "bg-primary animate-pulse"
        : "bg-threat";

  return (
    <div className="label-mono mt-1 flex items-center gap-1.5">
      <span className={`h-1.5 w-1.5 rounded-full ${dot}`} />
      <span className={state === "online" ? "text-telemetry" : state === "offline" ? "text-threat" : ""}>
        {state === "online" && data ? `Uplink stable · v${data.version}` : `Uplink ${state}`}
      </span>
    </div>
  );
}
