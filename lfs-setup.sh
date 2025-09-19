#!/bin/bash
source /root/lfs/lib/common-header.sh   # In every script.

main () {  # alwasy have main.
    echo "Hello World\n"
	echo "I, $SCRIPT_NAME, am at $HERE supposed to be lfs-setup.sh"
 	echo "running: $HERE/test/stage0.sh"
 	read
	read
 	$HERE/test/stage0.sh
	read
	read
	#	bash --noprofile --norc -i
 }



source /root/lfs/lib/common-footer.sh   # in every script.
