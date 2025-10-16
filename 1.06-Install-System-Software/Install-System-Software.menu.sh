#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
source /root/lfs/USB/userID.key  # Access Keys
export $SHARE, $SHARE_USER, $SHARE_PASS, $SHARE_VERS, $SHARE_ID
cd /root/lfs/1.04-XCompilingTempTools

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Install Basic System Software"
	echo " "
}

main() {
	menu_setup $HERE/Install-System-Software.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Main Packages"
	echoR "Install"
	return 1
}

bldManpages() { 
	echoL "Man-pages (6.15)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldIanaEtc() {
	echoL "Iana Etc 20250807"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGlibc() {
	echoL "Glibc (2.42)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldZlib() { 
	echoL "Zlib (1.3.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldBzip2() { 
	echoL "Bzip2 (1.0.8)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldXz() {
	echoL "Xz Utils (5.8.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}


bldLz4() { :; }
bldZstd() { :; }
bldFile() { :; }
bldReadline() { :; }
bldM4() { :; }
bldBc() { :; }
bldFlex() { :; }
bldTcl() { :; }
bldExpect() { :; }
bldDejaGNU() { :; }
bldPkgconf() { :; }
bldBinutils() { :; }
bldGMP() { :; }
bldMPFR() { :; }
bldMPC() { :; }
bldAttr() { :; }
bldAcl() { :; }
bldLibcap() { :; }
bldLibxcrypt() { :; }
bldShadow() { :; }
bldGCC() { :; }
bldNcurses() { :; }
bldSed() { :; }
bldPsmisc() { :; }
bldGettext() { :; }
bldBison() { :; }
bldGrep() { :; }
bldBash() { :; }
bldLibtool() { :; }
bldGDBM() { :; }
bldGperf() { :; }
bldExpat() { :; }
bldInetutils() { :; }
bldLess() { :; }
bldPerl() { :; }
bldXMLParser() { :; }
bldIntltool() { :; }
bldAutoconf() { :; }
bldAutomake() { :; }
bldOpenSSL() { :; }
bldLibelffromElfutils() { :; }
bldLibffi() { :; }
bldPython() { :; }
bldFlitCore() { :; }
bldPackaging() { :; }
bldWheel() { :; }
bldSetuptools() { :; }
bldNinja() { :; }
bldMeson() { :; }
bldKmod() { :; }
bldCoreutils() { :; }
bldDiffutils() { :; }
bldGawk() { :; }
bldFindutils() { :; }
bldGroff() { :; }
bldGRUB() { :; }
bldGzip() { :; }
bldIPRoute2() { :; }
bldKbd() { :; }
bldLibpipeline() { :; }
bldMake() { :; }
bldPatch() { :; }
bldTar() { :; }
bldTexinfo() { :; }
bldVim() { :; }
bldMarkupSafe() { :; }
bldJinja() { :; }
bldUdevfromSystemd() { :; }
bldManDB() { :; }
bldProcpsng() { :; }
bldUtillinux() { :; }
bldE2fsprogs() { :; }
bldSysklogd() { :; }
bldSysVinit() { :; }

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 0
https://chatgpt.com/g/g-p-68bf3444284c8191937ab3e8dcd8a503-iigs-linux-from-scratch-build/project
https://www.linuxfromscratch.org/lfs/view/stable/chapter03/packages.html
https://github.com/wakirk/Personal-lfs-iigs-install/tree/434aeed03f038aff88ac33cee6e32a63b904570d

/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	Utils (5.8.1) - 1,428 KB:
	Home page: https://tukaani.org/xz
	Download: https: .tar.xz
	MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3
	echoR "System Software"

	echoL "Downloading package (version)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://*.tar.xz *.tar.xz
	cp ../Packages/-.tar.xz /sources

	echoL "Unpack package (version)..."
	sleep 2
	cd /sources
	rm -fR
	tar -vxsf
	cd 

	echoL "Building package (version)..."
	sleep 2
	./configure 
	make

	echoL "Installing package (version)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR 

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1


bldLz4	na.sh	Undefined.
bldZstd	na.sh	Undefined.
bldFile	na.sh	Undefined.
bldReadline	na.sh	Undefined.
bldM4	na.sh	Undefined.
bldBc	na.sh	Undefined.
bldFlex	na.sh	Undefined.
bldTcl	na.sh	Undefined.
bldExpect	na.sh	Undefined.
bldDejaGNU	na.sh	Undefined.
bldPkgconf	na.sh	Undefined.
bldBinutils	na.sh	Undefined.
bldGMP	na.sh	Undefined.
bldMPFR	na.sh	Undefined.
bldMPC	na.sh	Undefined.
bldAttr	na.sh	Undefined.
bldAcl	na.sh	Undefined.
bldLibcap	na.sh	Undefined.
bldLibxcrypt	na.sh	Undefined.
bldShadow	na.sh	Undefined.
bldGCC	na.sh	Undefined.
bldNcurses	na.sh	Undefined.
bldSed	na.sh	Undefined.
bldPsmisc	na.sh	Undefined.
bldGettext	na.sh	Undefined.
bldBison	na.sh	Undefined.
bldGrep	na.sh	Undefined.
bldBash	na.sh	Undefined.
bldLibtool	na.sh	Undefined.
bldGDBM	na.sh	Undefined.
bldGperf	na.sh	Undefined.
bldExpat	na.sh	Undefined.
bldInetutils	na.sh	Undefined.
bldLess	na.sh	Undefined.
bldPerl	na.sh	Undefined.
bldXMLParser	na.sh	Undefined.
bldIntltool	na.sh	Undefined.
bldAutoconf	na.sh	Undefined.
bldAutomake	na.sh	Undefined.
bldOpenSSL	na.sh	Undefined.
bldLibelffromElfutils	na.sh	Undefined.
bldLibffi	na.sh	Undefined.
bldPython	na.sh	Undefined.
bldFlitCore	na.sh	Undefined.
bldPackaging	na.sh	Undefined.
bldWheel	na.sh	Undefined.
bldSetuptools	na.sh	Undefined.
bldNinja	na.sh	Undefined.
bldMeson	na.sh	Undefined.
bldKmod	na.sh	Undefined.
bldCoreutils	na.sh	Undefined.
bldDiffutils	na.sh	Undefined.
bldGawk	na.sh	Undefined.
bldFindutils	na.sh	Undefined.
bldGroff	na.sh	Undefined.
bldGRUB	na.sh	Undefined.
bldGzip	na.sh	Undefined.
bldIPRoute2	na.sh	Undefined.
bldKbd	na.sh	Undefined.
bldLibpipeline	na.sh	Undefined.
bldMake	na.sh	Undefined.
bldPatch	na.sh	Undefined.
bldTar	na.sh	Undefined.
bldTexinfo	na.sh	Undefined.
bldVim	na.sh	Undefined.
bldMarkupSafe	na.sh	Undefined.
bldJinja	na.sh	Undefined.
bldUdevfromSystemd	na.sh	Undefined.
bldManDB	na.sh	Undefined.
bldProcpsng	na.sh	Undefined.
bldUtillinux	na.sh	Undefined.
bldE2fsprogs	na.sh	Undefined.
bldSysklogd	na.sh	Undefined.
bldSysVinit	na.sh	Undefined.

