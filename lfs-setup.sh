#!/bin/bash

# --- Project bootstrap (simple & explicit) -----------------------------------
# 1) Set RUN_ROOT (project root) only if not already set
if [ -z "${RUN_ROOT:-}" ]; then
	SCRIPT_PATH="${BASH_SOURCE[0]}"                                # this file
	SCRIPT_DIR="$(cd -P -- "$(dirname -- "$SCRIPT_PATH")" && pwd)" # its folder
	RUN_ROOT="$SCRIPT_DIR"
	LFS="/mnt/lfs"  # if run_root is not set, this won't be either, do it now.
	# Make both available to all child processes/scripts
	export RUN_ROOT LFS  # only do this once as well.   All subsequent calls should now know where to go and what to do.
fi

# 5) Load shared UI/helpers into *this* shell (readable: 'source', not '.')
# this is not a bad iea, keeping it.  case something goes bonkers, don't make any more bonkers.
if [ -f "$RUN_ROOT/lib/lfs-ui.sh" ]; then
	source "$RUN_ROOT/lib/lfs-ui.sh"
else
	echo "Missing: $RUN_ROOT/lib/lfs-ui.sh" >&2
	exit 1
fi

main_routine () {
	echo "I, $SCRIPT_NAME, am at $HERE supposed to be lfs-setup.sh"
 	echo "running: $HERE/test/stage0.sh"
 	read
	read
 	$HERE/test/stage0.sh
	read
	read
	#	bash --noprofile --norc -i
 }

lfs_identity
lfs_tmux_entry main_routine

echo "Session Finished."
exit 0
