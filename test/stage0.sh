#!/bin/bash

#
# Bootstrap just enough path to source our shared UI/lib (canonical vars are set by the lib).
_BOOT_HERE="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. "$_BOOT_HERE/lib/lfs-ui.sh"
unset _BOOT_HERE


 main_routine () {
 	echo "I, $SCRIPT_NAME, am at $HERE supposed to be lfs-setup.sh"
 	echo "running: $HERE/test/stage0.sh"
 	read
	read
	bash --noprofile --norc -i
}

lfs_identity
lfs_tmux_entry main_routine

echo "Session Finished."
exit 0
