import { useEffect, useRef } from "react";
import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

/**
 * A lightweight, dependency-free rotating "globe" -- pure CSS/JS orthographic
 * projection, no three.js/globe library involved. A single requestAnimationFrame
 * loop mutates DOM refs directly (never React state) so the spin costs nothing
 * in render churn regardless of marker count.
 *
 * Projection: for a point at (lat, lon) in degrees, with current spin angle
 * `r` around the vertical axis --
 *   lonEff = lon + r
 *   x = radius * cos(lat) * sin(lonEff)   (screen-horizontal)
 *   y = radius * sin(lat)                 (screen-vertical, unaffected by spin)
 *   z = radius * cos(lat) * cos(lonEff)   (depth: +1 front .. -1 back)
 * Meridian rings use the same idea: a great circle at longitude `m` projects
 * to an ellipse whose horizontal half-width is radius * |sin(m + r)|.
 */

export interface GlobeMarker {
  id: string;
  label: string;
  sublabel?: string;
  lat: number;
  lon: number;
  icon?: LucideIcon;
  tone?: "primary" | "threat" | "telemetry";
  size?: "lg" | "sm";
  onClick?: () => void;
}

const TONE_STYLES: Record<NonNullable<GlobeMarker["tone"]>, { dot: string; ring: string; glow: string }> = {
  primary: { dot: "bg-primary", ring: "border-primary/70", glow: "0 0 16px 2px oklch(0.78 0.16 68 / 55%)" },
  threat: { dot: "bg-threat", ring: "border-threat/70", glow: "0 0 12px 2px oklch(0.66 0.21 22 / 55%)" },
  telemetry: { dot: "bg-telemetry", ring: "border-telemetry/70", glow: "0 0 12px 2px oklch(0.78 0.13 190 / 50%)" },
};

const DEG2RAD = Math.PI / 180;
const MERIDIANS = [0, 30, 60, 90, 120, 150];
const PARALLELS = [-60, -30, 0, 30, 60];

export function PathwayGlobe({
  markers,
  spinSpeed = 9,
  radius = 150,
  className,
}: {
  markers: GlobeMarker[];
  /** degrees per second */
  spinSpeed?: number;
  radius?: number;
  className?: string;
}) {
  const meridianRefs = useRef<(HTMLDivElement | null)[]>([]);
  const markerRefs = useRef<(HTMLDivElement | null)[]>([]);
  const rotationRef = useRef(0);

  useEffect(() => {
    const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    let raf = 0;
    let last = performance.now();

    function frame(now: number) {
      const dt = (now - last) / 1000;
      last = now;
      if (!reduceMotion) {
        rotationRef.current = (rotationRef.current + spinSpeed * dt) % 360;
      }
      const r = rotationRef.current;

      meridianRefs.current.forEach((el, i) => {
        if (!el) return;
        const m = MERIDIANS[i]!;
        const theta = (m + r) * DEG2RAD;
        const width = Math.max(2, Math.abs(Math.sin(theta)) * radius * 2);
        const front = Math.cos(theta) >= 0;
        el.style.width = `${width}px`;
        el.style.opacity = front ? "0.4" : "0.14";
        el.style.zIndex = front ? "1" : "0";
      });

      markers.forEach((marker, i) => {
        const el = markerRefs.current[i];
        if (!el) return;
        const lat = marker.lat * DEG2RAD;
        const lonEff = (marker.lon + r) * DEG2RAD;
        const x = Math.cos(lat) * Math.sin(lonEff) * radius;
        const y = Math.sin(lat) * radius;
        const z = Math.cos(lat) * Math.cos(lonEff);
        const depth = (z + 1) / 2; // 0 back .. 1 front
        const scale = 0.55 + depth * 0.55;
        el.style.transform = `translate(${x}px, ${-y}px) scale(${scale})`;
        el.style.opacity = String(0.25 + depth * 0.75);
        el.style.zIndex = String(Math.round(depth * 100) + 2);
      });

      raf = requestAnimationFrame(frame);
    }

    raf = requestAnimationFrame(frame);
    return () => cancelAnimationFrame(raf);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [markers, radius, spinSpeed]);

  return (
    <div
      className={cn("relative mx-auto grid place-items-center", className)}
      style={{ width: radius * 2 + 40, height: radius * 2 + 40, maxWidth: "100%" }}
      aria-hidden="true"
    >
      <div className="relative" style={{ width: radius * 2, height: radius * 2 }}>
        {/* sphere body */}
        <div
          className="absolute inset-0 rounded-full"
          style={{
            background:
              "radial-gradient(circle at 32% 28%, oklch(0.3 0.05 220 / 90%), oklch(0.19 0.03 258 / 95%) 60%, oklch(0.14 0.024 258 / 98%) 100%)",
            boxShadow: "inset 0 0 60px 10px oklch(0.1 0.02 258 / 70%), 0 0 70px -10px oklch(0.78 0.13 190 / 25%)",
            border: "1px solid oklch(0.78 0.13 190 / 25%)",
          }}
        />

        {/* static latitude rings (unaffected by y-axis spin) */}
        {PARALLELS.map((lat) => {
          const latRad = lat * DEG2RAD;
          const y = Math.sin(latRad) * radius;
          const w = Math.cos(latRad) * radius * 2;
          return (
            <div
              key={lat}
              className="absolute left-1/2 rounded-full border border-telemetry/20"
              style={{
                top: `calc(50% - ${y}px)`,
                width: w,
                height: Math.max(4, w * 0.14),
                transform: "translate(-50%, -50%)",
              }}
            />
          );
        })}

        {/* rotating meridian rings */}
        {MERIDIANS.map((m, i) => (
          <div
            key={m}
            ref={(el) => {
              meridianRefs.current[i] = el;
            }}
            className="absolute top-1/2 left-1/2 rounded-full border border-telemetry/40"
            style={{ height: radius * 2, transform: "translate(-50%, -50%)" }}
          />
        ))}

        {/* markers */}
        {markers.map((marker, i) => {
          const tone = TONE_STYLES[marker.tone ?? "primary"];
          const isLg = marker.size !== "sm";
          return (
            <div
              key={marker.id}
              ref={(el) => {
                markerRefs.current[i] = el;
              }}
              className="absolute top-1/2 left-1/2 will-change-transform"
              style={{ transform: "translate(0, 0)" }}
            >
              <button
                type="button"
                onClick={marker.onClick}
                disabled={!marker.onClick}
                className={cn(
                  "group grid -translate-x-1/2 -translate-y-1/2 place-items-center",
                  marker.onClick ? "cursor-pointer" : "cursor-default",
                )}
                title={marker.label}
              >
                <span
                  className={cn(
                    "grid place-items-center rounded-full border-2",
                    tone.ring,
                    isLg ? "h-4 w-4" : "h-2.5 w-2.5",
                  )}
                  style={{ boxShadow: tone.glow }}
                >
                  <span className={cn("rounded-full", tone.dot, isLg ? "h-1.5 w-1.5" : "h-1 w-1")} />
                </span>
                {isLg && (
                  <span className="label-mono absolute top-full mt-1.5 whitespace-nowrap text-foreground opacity-0 transition-opacity group-hover:opacity-100">
                    {marker.label}
                  </span>
                )}
              </button>
            </div>
          );
        })}
      </div>
    </div>
  );
}
