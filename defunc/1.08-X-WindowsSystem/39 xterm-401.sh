#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://invisible-mirror.net/archives/xterm/xterm-401.tgz
	# Download MD5 sum: 8b0617af50f7b8530aff5c6c0a8d0c0b
	# Download size: 1.5 MB
	# Estimated disk space required: 15 MB
	# Estimated build time: 0.2 SBU (with parallelism=4)
	echoR "System Software"

	echoL "Downloading xterm (401)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://invisible-mirror.net/archives/xterm/xterm-401.tgz xterm-401.tgz
	cp ../Packages/xterm-401.tgz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xterm (401)..."
	sleep 2
	cd /sources
	rm -fR xterm-401
	tar -vxsf xterm-401.tgz
	cd xterm-401

	echoL "Building xterm (401)..."
	sleep 2
	sed -i '/v0/{n;s/new:/new:kb=^?:/}' termcap
	printf '\tkbs=\\177,\n' >> terminfo

	TERMINFO=/usr/share/terminfo \
	./configure $XORG_CONFIG     \
		--with-app-defaults=/etc/X11/app-defaults
	make

	echoL "Installing xterm (401)..."
	sleep 2
	make install
	mkdir -pv /usr/share/applications
	cp -v *.desktop /usr/share/applications/

cat >> /etc/X11/app-defaults/XTerm << "EOF"
*VT100*locale: true
*VT100*faceName: Monospace
*VT100*faceSize: 10
*backarrowKeyIsErase: true
*ptyInitialErase: true
EOF
	read
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xterm-401

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
