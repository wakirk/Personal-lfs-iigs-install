#!/bin/bash
# fs-watch-tree.sh — per spec

# Files live in the script's directory
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
  tree /mnt/lfs -f -x > "$CURR_FILE"

  # 3) Show changes from previous -> current
  diff "$PREV_FILE" "$CURR_FILE" --context
  # 4) Wait
  sleep 1
done
