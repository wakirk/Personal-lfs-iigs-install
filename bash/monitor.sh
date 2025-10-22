#!/bin/bash
# fs-watch-tree.sh — per spec

# Files live in the script's directory
cd /mnt/lfs
SCRIPT_DIR="$(pwd)"
PREV_FILE="$SCRIPT_DIR/previous.dat"
CURR_FILE="$SCRIPT_DIR/current.dat"

# Scan root is where the script is run from
SCAN_ROOT="$PWD"

rm $CURR_FILE
rm $PREV_FILE
touch $CURR_FILE
touch $PREV_FILE

## Initialize: ensure previous.dat exists
#if [ ! -f "$PREV_FILE" ]; then
#  ( cd "$SCAN_ROOT" && tree -f -x ) > "$PREV_FILE"
#fi

## Ensure current.dat exists for first rotation
#if [ ! -f "$CURR_FILE" ]; then
#  cp -f "$PREV_FILE" "$CURR_FILE"
#fi

# Continuous loop (30 seconds)
echo "$PREV_FILE"
echo "$CURR_FILE"
echo "$SCRIPT_DIR"

while :; do
  # 1) Delete previous.dat and rename current.dat -> previous.dat
  rm -f "$PREV_FILE"
  mv -f "$CURR_FILE" "$PREV_FILE"

  # 2) Take a new snapshot into current.dat
  cd /mnt/lfs
  tree /mnt/lfs -f -x > "$CURR_FILE"

   printf '%*s' "$cols" ''
   # Move to second-to-last line
   rows=$(tput lines)
   cols=$(tput cols)
   tput cup $((rows-4)) 0

   # Clear the line by painting spaces, then return to col 0
   printf '%*s' "$cols" ''
   tput cup $((rows-4)) 0



#  tput el   # optional: clear to end of line
#  tput cup $((rows-2)) 0
  printf '\033[2K'             # fallback: CSI 2K clears entire line
  # 3) Show changes from previous -> current
  diff "$PREV_FILE" "$CURR_FILE" --context 2>/dev/null \
  | LC_ALL=C grep -E '^[!+-] ' \
  | grep -Fv -e '/mnt/lfs/sources/' -e '/mnt/lfs/tmp'
  echo " "

# diff "$PREV_FILE" "$CURR_FILE" --context 2>/dev/null | LC_ALL=C grep -E '^[!+-] '
#    diff "$PREV_FILE" "$CURR_FILE" --context 2>/dev/null \
#    | LC_ALL=C grep -E '^[!+-] ' \
#    | grep -Fv '/mnt/lfs/sources/'

#   diff "$PREV_FILE" "$CURR_FILE" --context 2>/dev/null | LC_ALL=C grep -E '^[!+-]'
#  diff "$PREV_FILE" "$CURR_FILE" --context | grep -E '^[+\-!]'
  # 4) Wait
  sleep 5
done
