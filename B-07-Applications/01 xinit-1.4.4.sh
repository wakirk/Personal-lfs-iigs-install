#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Xorg Libraries

	# Recommended (runtime only)
	#	twm-1.0.13.1
	#	xclock-1.1.1
	#	xterm-401 (used in the default xinitrc file)

main () {

	# Download (HTTP): https://www.x.org/pub/individual/app/xinit-1.4.4.tar.xz
	# Download MD5 sum: e7430a710261c9129b1280f26cb159a5
	# Download size: 160 KB
	# Estimated disk space required: 1.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 7 Applications"

	echoL "Downloading xinit (1.4.4)..."
	sleep 2
	cd "/root/lfs/B-07-Applications"
	../bash/Download.sh https://www.x.org/pub/individual/app/xinit-1.4.4.tar.xz xinit-1.4.4.tar.xz
	cp ../Packages/xinit-1.4.4.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xinit (1.4.4)..."
	sleep 2
	cd /sources
	rm -fR xinit-1.4.4
	tar -vxsf xinit-1.4.4.tar.xz
	cd xinit-1.4.4

	echoL "Building xinit (1.4.4)..."
	sleep 2
	./configure $XORG_CONFIG --with-xinitdir=/etc/X11/app-defaults &&
	make

	echoL "Installing xinit (1.4.4)..."
	sleep 2
	make install &&
	ldconfig
	# [Note] Note
	# If starting Xorg from the command line, the default instructions above start Xorg on the
	# current virtual terminal. It may be convenient to see Xorg and associated application
	# messages on the current virtual terminal, normally tty1, and start the graphical environment
	# on the first available unused virtual terminal, normally tty7. To do this, set the
	# suid bit on the Xorg application as the root user:

	# chmod u+s $XORG_PREFIX/bin/Xorg

	# At this point you can start Xorg on virtual terminal 7 with startx
	# <client arguments> -- vt7. Now you can toggle between tty1 and tty7 with the Ctrl-Alt-F1
	# and Ctrl-Alt-F7 key combinations.

	# To automatically start Xorg on the first available virtual terminal, modify the startx script as the root user with:
	sed -i '/$serverargs $vtarg/ s/serverargs/: #&/' $XORG_PREFIX/bin/startx

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xinit-1.4.4

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
