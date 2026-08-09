/**
 * Non-filesystem host state a simulated Linux box exposes: processes,
 * services, packages, crontab, journal/log buffer, environment. Seeded from
 * mission `content` and mutated in-session (kill removes a pid, systemctl
 * flips a service's status) so multi-step admin missions (World 11:
 * "remove the unauthorized service, restore the legitimate one") work
 * without bespoke per-mission engine code.
 */

export interface ProcessSpec {
  pid: number;
  user: string;
  cmd: string;
  cpu?: number;
  mem?: number;
}

export type ServiceStatus = "active" | "inactive" | "failed";

export interface ServiceSpec {
  name: string;
  status: ServiceStatus;
  description?: string;
  enabled?: boolean;
  unauthorized?: boolean;
}

export interface PackageSpec {
  name: string;
  version: string;
}

export interface CronEntrySpec {
  schedule: string;
  user?: string;
  command: string;
}

export interface JournalEntrySpec {
  timestamp: string;
  unit?: string;
  message: string;
}

export interface ConnectionSpec {
  proto: string;
  localAddress: string;
  localPort: number;
  state: string;
  process?: string;
}

export interface ScanPortSpec {
  port: number;
  proto: "tcp" | "udp";
  state?: string;
  service: string;
  banner?: string;
}

export interface ScanTargetSpec {
  host: string;
  ports: ScanPortSpec[];
}

export interface DnsRecordSpec {
  domain: string;
  records: { type: string; value: string }[];
}

export interface WhoisRecordSpec {
  domain: string;
  lines: string[];
}

export interface Subsystems {
  processes: Map<number, ProcessSpec>;
  services: Map<string, ServiceSpec>;
  packages: PackageSpec[];
  cron: CronEntrySpec[];
  journal: JournalEntrySpec[];
  env: Record<string, string>;
  connections: ConnectionSpec[];
  scanTargets: ScanTargetSpec[];
  dnsRecords: DnsRecordSpec[];
  whoisRecords: WhoisRecordSpec[];
}

export interface SubsystemsSpec {
  processes?: ProcessSpec[];
  services?: ServiceSpec[];
  packages?: PackageSpec[];
  cron?: CronEntrySpec[];
  journal?: JournalEntrySpec[];
  env?: Record<string, string>;
  connections?: ConnectionSpec[];
  scanTargets?: ScanTargetSpec[];
  dnsRecords?: DnsRecordSpec[];
  whoisRecords?: WhoisRecordSpec[];
}

export function buildSubsystems(spec: SubsystemsSpec = {}): Subsystems {
  return {
    processes: new Map((spec.processes ?? []).map((p) => [p.pid, p])),
    services: new Map((spec.services ?? []).map((s) => [s.name, s])),
    packages: spec.packages ?? [],
    cron: spec.cron ?? [],
    journal: spec.journal ?? [],
    env: { ...(spec.env ?? {}) },
    connections: spec.connections ?? [],
    scanTargets: spec.scanTargets ?? [],
    dnsRecords: spec.dnsRecords ?? [],
    whoisRecords: spec.whoisRecords ?? [],
  };
}

export interface SubsystemResult {
  ok: boolean;
  error?: string;
}

export function killProcess(subsystems: Subsystems, pid: number): SubsystemResult {
  if (!subsystems.processes.has(pid)) {
    return { ok: false, error: `kill: (${pid}): No such process` };
  }
  subsystems.processes.delete(pid);
  return { ok: true };
}

export function serviceAction(
  subsystems: Subsystems,
  name: string,
  action: "start" | "stop" | "restart" | "enable" | "disable",
): SubsystemResult {
  const svc = subsystems.services.get(name);
  if (!svc) return { ok: false, error: `Unit ${name}.service could not be found.` };
  switch (action) {
    case "start":
    case "restart":
      svc.status = "active";
      break;
    case "stop":
      svc.status = "inactive";
      break;
    case "enable":
      svc.enabled = true;
      break;
    case "disable":
      svc.enabled = false;
      break;
  }
  return { ok: true };
}
