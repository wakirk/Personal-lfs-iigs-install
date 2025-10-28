#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://downloads.sourceforge.net/freetype/freetype-2.13.3.tar.xz
	# Download MD5 sum: f3b4432c4212064c00500e1ad63fbc64
	# Download size: 2.5 MB
	# Estimated disk space required: 33 MB (with additional documentation)
	# Estimated build time: 0.2 SBU (with additional documentation)

	# Download (HTTP): https://downloads.sourceforge.net/freetype/freetype-doc-2.13.3.tar.xz
	# Download MD5 sum: 6affe0d431939398cc3c7cdd58d824f8
	# Download size: 2.1 MB
	echoR "System Software"

	echoL "Downloading freetype (2.13.3)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
	../bash/Download.sh https://downloads.sourceforge.net/freetype/freetype-2.13.3.tar.xz freetype-2.13.3.tar.xz
	cp ../Packages/freetype-2.13.3.tar.xz /sources

	echoL "Downloading freetype docs (2.13.3)..."
	../bash/Download.sh https://downloads.sourceforge.net/freetype/freetype-doc-2.13.3.tar.xz freetype-doc-2.13.3.tar.xz
	cp ../Packages/freetype-doc-2.13.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack freetype (2.13.3)..."
	sleep 2
	cd /sources
	rm -fR freetype-2.13.3
	tar -vxsf freetype-2.13.3.tar.xz
	cd freetype-2.13.3

	echoL "Building freetype (2.13.3)..."
	sleep 2
	tar -vxsf ../freetype-doc-2.13.3.tar.xz --strip-components=2 -C docs
	sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg
	sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" -i include/freetype/config/ftoption.h
	./configure --prefix=/usr --without-harfbuzz --enable-freetype-config --disable-static
	make

	echoL "Installing freetype (2.13.3)..."
	sleep 2
	make install
	cp -fv -R docs -T /usr/share/doc/freetype-2.13.3 &&
	rm -fv /usr/share/doc/freetype-2.13.3/freetype-config.1

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR freetype-2.13.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
