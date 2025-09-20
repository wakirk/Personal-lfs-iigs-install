#!/bin/bash
source /root/lfs/lib/common-header.lib   # In every script.
source /root/lfs/lib/menu_system.lib

test_func() {
    echo "Test Function called with $HERE."
	read
	return 0
} #	stage0	Test Function

test_func2() {
    echo "Test Function called with $HERE."
	read
	return 0
} #	stage1	Test Second Function



main () {  # alwasy have main.
	menu_setup /root/lfs/mainmenu.tsv
	echo "Hello World."
	menu_load
	menu_run
	menu_save

#	echo "I, $SCRIPT_NAME, am at $HERE supposed to be lfs-setup.sh"
# 	echo "running: $HERE/test/stage0.sh"
# 	read
#	read
# 	$HERE/test/stage0.sh
#	read
#	read
	#	bash --noprofile --norc -i
	read

}



source /root/lfs/lib/common-footer.lib   # in every script.
