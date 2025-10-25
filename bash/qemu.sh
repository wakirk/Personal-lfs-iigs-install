#!/bin/bash
# umount-lfs-hard.sh — Firmly detach /mnt/lfs (and any submounts).
# Default: do NOT kill holder processes. Add --kill to terminate them (TERM → KILL).


umount -v /dev/nvme0n1p*

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
fi

while true; do
    fsck /dev/nvme0n1p1
    rc=$?
    [ "$rc" -eq 0 ] && break
    sleep 1
done

while true; do
    fsck /dev/nvme0n1p2
    rc=$?
    [ "$rc" -eq 0 ] && break
    sleep 1
done

lsblk
# qemu-boot-lfs.sh — BOOT /dev/nvme0n1 via UEFI in QEMU (WRITEABLE)
# WARNING: Writing to a disk that is mounted on the host can corrupt it.
# Set FORCE=1 to bypass the mounted-partitions check.

#pacman -Sy --noconfirm edk2-ovmf

# does load.
#qemu-system-x86_64 -machine q35 -m 4096 \
#  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd \
#  -drive if=pflash,format=raw,file=/usr/share/edk2-ovmf/x64/OVMF_VARS.4m.fd \
#  -drive file=/dev/nvme0n1,format=raw,if=virtio,cache=none

blockdev --getro /dev/nvme0n1
blockdev --setrw /dev/nvme0n1
qemu-system-x86_64 -machine q35 -enable-kvm -cpu host -m 4096 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd \
  -drive if=pflash,format=raw,file=/usr/share/edk2-ovmf/x64/OVMF_VARS.4m.fd \
  -drive file=/dev/nvme0n1,format=raw,if=ide,cache=none,discard=unmap \
  -boot order=c,menu=on,splash-time=5 -device virtio-vga \
  -netdev tap,id=n0,ifname=tap0,script=no,downscript=no \
  -device virtio-net-pci,netdev=n0 \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-mouse \
  -blockdev driver=host_device,filename=/dev/sdc,node-name=usbstick,cache.direct=on,cache.no-flush=off \
  -device usb-storage,drive=usbstick \
  -netdev user,id=net0      \
  -device e1000,netdev=net0 \
  -vga virtio \
  -display gtk,zoom-to-fit=on,full-screen=on

#    -enable-kvm        \
#    -cpu host -m 2048  \
#    -netdev user,id=net0      \
#    -device e1000,netdev=net0 \
#    -vga virtio \
#    -kernel /mnt/lfs/boot/vmlinuz-6.10.5-lfs-12.2    \
#    -append "root=/dev/vda video=1067x600 video=virtiofb:1067x600 rw fbcon=font:VGA8x16 consoleblank=0" \
#    -drive file=/dev/nvme0n1p3,format=raw,if=virtio \
#    -display gtk,zoom-to-fit=on,full-screen=on


#  -drive file=/dev/nvme0n1,format=raw,if=virtio,cache=none,discard=unmap \


# Prepare mountpoints
echo "Making mount points..."
mkdir -pv /mnt/lfs

# Mount root
echo "Mounting root..."
mount -v /dev/nvme0n1p2 /mnt/lfs

# Prepare mountpoints
echo "Making mount points..."
mkdir -pv /mnt/lfs/boot/efi

# Mount EFI
echo "Mounting EFI..."
mount -v /dev/nvme0n1p1 /mnt/lfs/boot/efi


