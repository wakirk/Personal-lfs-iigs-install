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

bldLz4() {
	echoL "Lz4 (1.10.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldZstd() { 
	echoL "Zstd (1.5.7)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldFile() {
	echoL "File (5.46)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldReadline() { 
	echoL "Readline (8.3)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}
 
bldM4() { 
	echoL "M4 (1.4.20)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldBc() { 
	echoL "Bc (7.0.3)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldFlex() {
	echoL "Flex (2.6.4)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldTcl() {
	echoL "Tcl (8.6.16)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldExpect() {
	echoL "Expect (5.45.4)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldDejaGNU() {
	echoL "DejaGNU (1.6.3)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldPkgconf() {
	echoL "Pkgconf (2.5.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldBinutils() {
	echoL "Binutils (2.45)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGMP() {
	echoL "GMP (6.3.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldMPFR() {
	echoL "MPFR (4.2.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldMPC() {
	echoL "MPC (1.3.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldAttr() {
	echoL "Attr (2.5.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldAcl() {
	echoL "Acl (2.3.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldLibcap() {
	echoL "Libcap (2.76)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldLibxcrypt() {
	echoL "Libxcrypt (4.4.38)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldShadow() {
	echoL "Shadow (4.18.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGCC() {
	echoL "GCC (15.2.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldNcurses() {
	echoL "Ncurses (6.5-20250809)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldSed() {
	echoL "Sed (4.9)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldPsmisc() {
	echoL "Psmisc (23.7)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGettext() {
	echoL "Gettext (0.26)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldBison() {
	echoL "Bison (3.8.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGrep() {
	echoL "Grep (3.12)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldBash() {
	echoL "Bash (5.3)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldLibtool() {
	echoL "Libtool (2.5.4)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGDBM() {
	echoL "GDBM (1.26)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGperf() {
	echoL "Gperf (3.3)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldExpat() {
	echoL "Expat (2.7.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldInetutils() {
	echoL "Inetutils (2.6)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldLess() {
	echoL "Less (679)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldPerl() {
	echoL "Perl (5.42.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldXMLParser() {
	echoL "XML::Parser (2.47)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldIntltool() {
	echoL "Intltool (0.51.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldAutoconf() {
	echoL "Autoconf (2.72)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldAutomake() {
	echoL "Automake (1.18.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldOpenSSL() {
	echoL "OpenSSL (3.6.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldLibelffromElfutils() {
	echoL "Libelf from Elfutils (0.193)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldLibffi() {
	echoL "Libffi (3.5.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldPython() {
	echoL "Python (3.13.7)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldFlitCore() {
	echoL "Flit-core (3.12.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldPackaging() {
	echoL "Packaging (25.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldWheel() {
	echoL "Wheel (0.46.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldSetuptools() {
	echoL "Setuptools (80.9.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldNinja() {
	echoL "Ninja (1.13.1)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldMeson() {
	echoL "Meson (1.8.3)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldKmod() {
	echoL "Kmod (34.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldCoreutils() {
	echoL "Coreutils (9.7)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldDiffutils() {
	echoL "Diffutils (3.12)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGawk() {
	echoL "Gawk (5.3.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldFindutils() {
	echoL "Findutils (4.10.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGroff() {
	echoL "Groff (1.23.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGRUB() {
	echoL "GRUB (2.12) for EFI (Minimal)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldGzip() {
	echoL "Gzip (1.14)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

bldIPRoute2() {
	echoL "IPRoute2 (6.16.0)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

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

	echoL "Downloading ------- ( ) ..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://*.tar.xz *.tar.xz
	cp ../Packages/-.tar.xz /sources

	echoL "Unpack ------- ( ) ..."
	sleep 2
	cd /sources
	rm -fR
	tar -vxsf
	cd 

	echoL "Building ------- ( ) ..."
	sleep 2

	echoL "Testing ------- ( ) ..."
	sleep 2
	/bin/bash

	echoL "Installing ------- ( ) ..."
	sleep 2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR 

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1

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

