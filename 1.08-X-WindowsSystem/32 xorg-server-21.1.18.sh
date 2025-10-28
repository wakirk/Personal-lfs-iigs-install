#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://www.x.org/pub/individual/xserver/xorg-server-21.1.18.tar.xz
	# Download MD5 sum: 43225ddc1fd8d7ae7671c25ab6d1f927
	# Download size: 4.9 MB
	# Estimated disk space required: 151 MB (with tests)
	# Estimated build time: 0.3 SBU (using parallelism=4; with tests)

	# Additional Downloads
	# With the removal of the xf86-video-* drivers, the TearFree option is no longer functional. To work around this, upstream has added the TearFree option to the default modesetting driver. This patch backports this feature. Apply this patch if you are going to use Xorg in an environment without a compositor (such as TWM, IceWM, Openbox, or Fluxbox).
	# Optional patch: https://www.linuxfromscratch.org/patches/blfs/12.4/xorg-server-21.1.18-tearfree_backport-1.patch
	echoR "System Software"

	echoL "Downloading xorg-server (21.1.18)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://www.x.org/pub/individual/xserver/xorg-server-21.1.18.tar.xz xorg-server-21.1.18.tar.xz
	cp ../Packages/xorg-server-21.1.18.tar.xz /sources

	echoL "Downloading xorg-server (21.1.18) patch..."
	../bash/Download.sh https://www.linuxfromscratch.org/patches/blfs/12.4/xorg-server-21.1.18-tearfree_backport-1.patch xorg-server-21.1.18-tearfree_backport-1.patch
	cp ../Packages/xorg-server-21.1.18-tearfree_backport-1.patch /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack xorg-server (21.1.18)..."
	sleep 2
	cd /sources
	rm -fR xorg-server-21.1.18
	tar -vxsf xorg-server-21.1.18.tar.xz
	cd xorg-server-21.1.18

	echoL "Patching xorg-server (21.1.18)..."
	sleep 2
	patch -Np1 -i ../xorg-server-21.1.18-tearfree_backport-1.patch

	echoL "Building xorg-server (21.1.18)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..         \
	--prefix=$XORG_PREFIX  \
	--localstatedir=/var   \
	-D glamor=true         \
	-D systemd_logind=true \
	-D secure-rpc=false    \
	-D xkb_output_dir=/var/lib/xkb
	ninja

	echoL "Installing xorg-server (21.1.18)..."
	sleep 2
	ninja install
	mkdir -pv /etc/X11/xorg.conf.d
	install -v -d -m1777 /tmp/.{ICE,X11}-unix
	cat >> /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR xorg-server-21.1.18

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
