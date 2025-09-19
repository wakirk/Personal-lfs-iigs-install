#!/bin/bash
source /root/lfs/lib/common-header.lib   # In every script.
source /root/lfs/lib/menu_system.lib


test_func () {
    echo "Test Function called with $HERE."
	return 0
}

main () {  # alwasy have main.
    menu_setup /root/lfs/mainmenu.tsv
    echo "Hello World\n"3
	read
	
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
 }



source /root/lfs/lib/common-footer.lib   # in every script.
