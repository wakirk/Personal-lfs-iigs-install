#!/bin/bash
# umount-lfs-hard.sh — Firmly detach /mnt/lfs (and any submounts).
# Default: do NOT kill holder processes. Add --kill to terminate them (TERM → KILL).

set -u

TARGET="/mnt/lfs"
DO_KILL=0

usage() {
  cat <<EOF
Usage: $0 [--kill]

Actions:
  1) Show mounts and processes using $TARGET
  2) Remount read-only (best effort)
  3) Unmount submounts deepest-first
  4) Lazy unmount top-level
  5) If still mounted: (optional) kill holders, then hard unmount

Options:
  --kill    Send SIGTERM, then SIGKILL to any PIDs holding $TARGET if needed.
EOF
}

# --- args ---
while [ $# -gt 0 ]; do
  case "$1" in
    --kill) DO_KILL=1;;
    -h|--help) usage; exit 0;;
    *) echo "Unknown option: $1"; usage; exit 2;;
  esac
  shift || true
done

# --- preflight ---
if ! command -v findmnt >/dev/null 2>&1; then
  echo "Missing 'findmnt' (util-linux)."; exit 3
fi

if ! command -v mountpoint >/dev/null 2>&1; then
  echo "Missing 'mountpoint' (util-linux)."; exit 3
fi

if ! mountpoint -q "$TARGET"; then
  echo "$TARGET is not a mountpoint (already unmounted?)."
  exit 0
fi

echo "Inspecting mounts under $TARGET..."
# List all mounts under /mnt/lfs (including itself), deepest first
mapfile -t MOUNTS < <(findmnt -Rno TARGET "$TARGET" | awk '{print length,$0}' | sort -nr | cut -d' ' -f2-)

echo "Mounted paths (deepest first):"
for m in "${MOUNTS[@]}"; do
  echo "  $m"
done

echo "Finding processes using $TARGET (best effort)..."
FUSER_OUT="$(fuser -vm "$TARGET" 2>/dev/null || true)"
if [ -n "$FUSER_OUT" ]; then
  printf '%s\n' "$FUSER_OUT"
else
  echo "(no processes reported by fuser)"
fi

if command -v lsof >/dev/null 2>&1; then
  echo "lsof summary (first 10 lines):"
  lsof +f -- "$TARGET" 2>/dev/null | head -n 10
fi

echo "Syncing and attempting to remount read-only (best effort)..."
sync || true
mount -o remount,ro "$TARGET" 2>/dev/null || true

# --- unmount submounts deepest-first ---
echo "Detaching submounts from deepest to shallowest (lazy first)..."
for m in "${MOUNTS[@]}"; do
  if mountpoint -q "$m"; then
    umount -l "$m" 2>/dev/null || true
  fi
done

# Final attempts on the top-level target
if mountpoint -q "$TARGET"; then
  echo "Top-level still mounted; attempting lazy detach..."
  umount -l "$TARGET" 2>/dev/null || true
fi

# If still mounted, optionally kill holders and hard-force
if mountpoint -q "$TARGET"; then
  echo "$TARGET still mounted after lazy detach."

  if [ "$DO_KILL" -eq 1 ]; then
    echo "Terminating holder processes (TERM then KILL if needed)..."
    mapfile -t PIDS < <(fuser -vm "$TARGET" 2>/dev/null | awk 'NR>1 {for(i=1;i<=NF;i++){ if ($i ~ /^[0-9]+$/) print $i }}' | sort -u)

    if [ "${#PIDS[@]}" -gt 0 ]; then
      echo "PIDs: ${PIDS[*]}"
      kill -TERM "${PIDS[@]}" 2>/dev/null || true
      sleep 1
      mapfile -t PIDS2 < <(fuser -vm "$TARGET" 2>/dev/null | awk 'NR>1 {for(i=1;i<=NF;i++){ if ($i ~ /^[0-9]+$/) print $i }}' | sort -u)
      if [ "${#PIDS2[@]}" -gt 0 ]; then
        echo "Some PIDs remain after TERM; sending KILL..."
        kill -KILL "${PIDS2[@]}" 2>/dev/null || true
        sleep 1
      fi
    else
      echo "No holder PIDs found by fuser."
    fi

    echo "Attempting hard unmount..."
    umount -f "$TARGET" 2>/dev/null || true
  else
    echo "Skipping process termination (no --kill). Attempting hard unmount anyway..."
    umount -f "$TARGET" 2>/dev/null || true
  fi
fi

# --- result ---
if mountpoint -q "$TARGET"; then
  echo "FAILED: $TARGET is still mounted."
  echo "You can rerun with: $0 --kill"
  exit 1
else
  echo "SUCCESS: $TARGET is unmounted."
  exit 0
fi
