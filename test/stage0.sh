#!/bin/bash
source /root/lfs/lib/common-header.sh   # In every script.



main () {  # alwasy have main.
	echo "Hello World\n"
	echo "I, $SCRIPT_NAME, am at $HERE supposed to be stage0.sh"
	bash --noprofile --norc -i
	read
 }



source /root/lfs/lib/common-footer.sh   # in every script.
