#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.08-X-WindowsSystem

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     X Windows System"
	echo " "
}

main() {
	menu_setup $HERE/LFS-Bootable.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Window System"
	echoR "X Windows"
	return 1
}

Winxorgproto() {
	echoL "xorgproto (2024.1)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}


WinlibXau() {
	echoL "libXau (1.0.12)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

WinlibXdmcp() {
	echoL "libXdmcp (1.1.5)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Winxtrans() {
	echoL "xtrans (1.6.0)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Winxcbproto() {
	echoL "xcb-proto (1.17.0)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Winlibxcb() {
	echoL "libxcb (1.17.0)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

WinlibX11() {
	echoL "libX11 (1.8.12)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

WinlibXext() {
	echoL "libXext (1.3.6)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Winpixman() {
	echoL "pixman (0.46.4)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibxcvt() {
	echoL "libxcvt (0.1.3)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Winxkeyboardconfig() {
	echoL "xkeyboard-config (2.45)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winfontutil() {
	echoL "font-util (1.4.1)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibdrm() {
	echoL "libdrm (2.4.125)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winmako() {
	echoL "Mako (1.3.10)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winpyyaml() {
	echoL "PyYAML (6.0.2)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibXfixes() {
	echoL "libXfixes (6.0.1)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibxshmfence() {
	echoL "libxshmfence (1.3.3)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibXxf86vm() {
	echoL "libXxf86vm (1.1.6)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibXrender() {
	echoL "libXrender (0.9.12)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibXrandr() {
	echoL "libXrandr (1.5.4)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winmesa() {
	echoL "Mesa (25.1.8)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibepoxy() {
	echoL "libepoxy (1.5.10)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibevdev() {
	echoL "libevdev (1.13.4)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibinput() {
	echoL "libinput (1.29.0)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winmtdev() {
	echoL "mtdev (1.1.7)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibxkbfile() {
	echoL "libxkbfile (1.1.3)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibfontenc() {
	echoL "libfontenc (1.1.8)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

windbus() {
	echoL "dbus (1.16.2)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winfreetype() {
	echoL "freetype (2.13.3)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

libXfont2() {
	echoL "libXfont2 (2.0.7)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winlibpciaccess() {
	echoL "libpciaccess (0.18.1)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winxorgserver() {
	echoL "xorg-server (21.1.18)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winxorglibinput() {
	echoL "xf86 input libinput (1.5.0)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winelogind() {
	echoL "elogind (255.17)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winxinit() {
	echoL "xinit (1.4.4)"
	echoR "Client Components"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

winxkbcomp() {
	echoL "xkbcomp (1.4.7)"
	echoR "Client Components"
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
