#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.

cd "/root/lfs/B-05-Xorg Libraries and Mesa"

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     BLFS Xorg Libraries and Mesa"
	echo "     X Windows System Build"
	echo " "
}

main() {
	menu_setup "$HERE/BLFS-Libraries and Mesa.menu.tsv"
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Xorg Libraries and Mesa"
	echoR "BLFS X Windows Build"
	return 1
}

blfsSPIRVHeaders143210() {
	echoL "SPIRV-Headers (1.4.321.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
		return_wait 1
	return 1
}

blfsSPIRVTools143210() {
	echoL "SPIRV-Tools (1.4.321.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsLLVM2018() {
	echoL "LLVM (20.1.8)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsFontconfig2171() {
	echoL "Fontconfig (2.17.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsXorgLibraries() {
	echoL "Xorg Libraries"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsLibdrm24125() {
	echoL "Libdrm (2.4.125)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsSPIRVLLVMTrans2015() {
	echoL "SPIRV-LLVM-Translator (20.1.5)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsRustc1890() {
	echoL "Rustc (1.89.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsCbindgen0290() {
	echoL "Cbindgen (0.29.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsrustbindgen0720() {
	echoL "rust-bindgen (0.72.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibclc2018() {
	echoL "libclc (20.1.8)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibvdpau15() {
	echoL "libvdpau (1.5)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsglslang1540() {
	echoL "glslang (15.4.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsVulkanHeaders14321() {
	echoL "Vulkan-Headers (1.4.321)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsVulkanLoader14321() {
	echoL "Vulkan-Loader (1.4.321)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsdmidecode36() {
	echoL "DMI Decode (3.6)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsCairo1184() {
	echoL "Cairo (1.18.4)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsFriBidi1016() {
	echoL "FriBidi (1.0.16)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsPango1564() {
	echoL "Pango (1.56.4)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsrrdtool190() {
	echoL "RRD tool (1.9.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslmsensors362() {
	echoL "lm-sensors (3.6.2)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfslibva2220() {
	echoL "libva (2.22.0)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsgmmlib2281() {
	echoL "gmmlib (22.8.1)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsintelmediadriver2526() {
	echoL "Intel Media Driver (25.2.6)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

blfsMesa2518() {
	echoL "Mesa (25.1.8)"
	echoR "BLFS X System Build"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}


#	export XORG_PREFIX="/usr"
#	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
