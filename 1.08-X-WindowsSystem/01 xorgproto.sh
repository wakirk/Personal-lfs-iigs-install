#/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# 1. xorgproto	— Header files describing X11/extension protocols; needed to build X libraries.
	# xorgproto (2024.1)
	# https://www.linuxfromscratch.org/blfs/view/stable/x/xorgproto.html
	# https://superuser.com/questions/904142/launching-programs-with-gui-without-display-manager?utm_source=chatgpt.com
	# Download (HTTP): https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz
	# Download MD5 sum: 12374d29fb5ae642cfa872035e401640
	# Download size: 744 KB
	# Estimated disk space required: 8.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "System Software"

	echoL "Downloading util-macros 1.20.2..."
	cd "/root/lfs/1.08-X-WindowsSystem"
	# https://www.x.org/pub/individual/util/util-macros-1.20.2.tar.xz
	../bash/Download.sh https://www.x.org/pub/individual/util/util-macros-1.20.2.tar.xz util-macros-1.20.2.tar.xz
	cp ../Packages/util-macros-1.20.2.tar.xz /sources

	echoL "Downloading xorgproto (2024.1)..."
	sleep 2
	../bash/Download.sh https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz xorgproto-2024.1.tar.xz
	cp ../Packages/xorgproto-2024.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	cd /sources
	echoL "Unpack util-macros 1.20.2..."
	rm -fR util-macros-1.20.2
	tar -vxsf util-macros-1.20.2.tar.xz
	cd util-macros-1.20.2

	echoL "Building util-macros 1.20.2..."
	./configure $XORG_CONFIG

	echoL "Installing util-macros 1.20.2..."
	make install

	echoL "Unpack xorgproto (2024.1)..."
	sleep 2
	cd /sources
	rm -fR xorgproto-2024.1
	tar -vxsf xorgproto-2024.1.tar.xz
	cd xorgproto-2024.1

	echoL "Building xorgproto (2024.1)..."
	sleep 2
	mkdir build
	cd    build
	meson setup --prefix=$XORG_PREFIX ..
	ninja

	echoL "Installing xorgproto (2024.1)..."
	sleep 2
	ninja install
	mv -fv $XORG_PREFIX/share/doc/xorgproto{,-2024.1}

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR util-macros-1.20.2
	rm -fR xorgproto-2024.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
