#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	duktape-2.7.0 
	#	GLib-2.84.4 (GObject Introspection recommended)

	# Recommended
	#	libxslt-1.1.43
	#	Linux-PAM-1.7.1
	#	elogind-255.17

	# [Note] Note
	# Since elogind uses PAM to register user sessions, it is a good idea to build Polkit with PAM support so elogind
	# can track Polkit sessions.

	# Optional
	#	GTK-Doc-1.34.0
	#	dbusmock-0.36.0 (required for tests)

	# Optional Runtime Dependencies
	# One polkit authentication agent for using polkit in the graphical environment:
	#	polkit-kde-agent in Plasma-6.4.4 for KDE,
	#	the agent built in gnome-shell-48.4 for GNOME3,
	#	polkit-gnome-0.105 for XFCE,
	#	lxqt-policykit-2.2.0 for LXQt

	#	[Note] Note
	#	If libxslt-1.1.43 is installed, then docbook-xml-4.5 and docbook-xsl-nons-1.79.2 are required.
	#	If you have installed libxslt-1.1.43, but you do not want to install any of the DocBook
	#	packages mentioned, you will need to use -D man=false in the instructions below.

main () {

	# Download (HTTP): https://github.com/polkit-org/polkit/archive/126/polkit-126.tar.gz
	# Download MD5 sum: db4ce0a42d5bf8002061f8e34ee9bdd0
	# Download size: 448 KB
	# Estimated disk space required: 7.4 MB (with tests)
	# Estimated build time: 0.2 SBU (with tests; using parallelism=4)
	echoR "Group 6 Xorg Applications and Fonts"

	echoL "Downloading Polkit (126)..."
	sleep 2
	cd "/root/lfs/B-06-Xorg Applications and Fonts"
	../bash/Download.sh https://github.com/polkit-org/polkit/archive/126/polkit-126.tar.gz polkit-126.tar.gz
	cp ../Packages/polkit-126.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Polkit (126)..."
	sleep 2
	cd /sources
	rm -fR polkit-126
	tar -vxsf polkit-126.tar.gz
	cd polkit-126

	echoL "Building Polkit (126)..."
	sleep 2
	groupadd -fg 27 polkitd &&
	useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 -g polkitd -s /bin/false polkitd
	mkdir build &&
	cd    build &&
	meson setup ..                   \
		--prefix=/usr                \
		--buildtype=release          \
		-D man=true                  \
		-D session_tracking=elogind  \
		-D os_type=lfs               \
		-D systemdsystemunitdir=/tmp \
		-D tests=true
	ninja

	echoL "Installing Polkit (126)..."
	sleep 2
	ninja install
	rm -v /tmp/*.service
	rm -rf /usr/lib/{sysusers,tmpfiles}.d 

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR polkit-126

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
