#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Recommended
	#	harfBuzz-11.4.1 (circular: build freetype, then harfbuzz, then reinstall freetype)
	#	libpng-1.6.50, and Which-2.23

	# Optional
	#	Brotli-1.1.0
	#	librsvg-2.61.0

	# Optional (for documentation)
	#	docwriter

# Command Explanations
# sed -ri ...: First command enables GX/AAT and OpenType table validation and second command enables Subpixel Rendering. Note that Subpixel Rendering may have patent issues. Be sure to read the 'Other patent issues' part of https://freetype.org/patents.html before enabling this option.
# --enable-freetype-config: This switch ensure that the man page for freetype-config is installed.
# --without-harfbuzz: If harfbuzz is installed prior to freetype without freetype support, use this switch to avoid a build failure.
# --disable-static: This switch prevents installation of static versions of the libraries.

main () {

	# Download (HTTP): https://downloads.sourceforge.net/freetype/freetype-2.13.3.tar.xz
	# Download MD5 sum: f3b4432c4212064c00500e1ad63fbc64
	# Download size: 2.5 MB
	# Estimated disk space required: 33 MB (with additional documentation)
	# Estimated build time: 0.2 SBU (with additional documentation)

	# Additional Documentation
	# Download (HTTP): https://downloads.sourceforge.net/freetype/freetype-doc-2.13.3.tar.xz
	# Download MD5 sum: 6affe0d431939398cc3c7cdd58d824f8
	# Download size: 2.1 MB
	echoR "Group 4 Security Layer"

	echoL "Downloading FreeType (2.13.3) Pass 1..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://downloads.sourceforge.net/freetype/freetype-2.13.3.tar.xz freetype-2.13.3.tar.xz
	cp ../Packages/freetype-2.13.3.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack FreeType (2.13.3) Pass 1..."
	sleep 2
	cd /sources
	rm -fR freetype-2.13.3
	tar -vxsf freetype-2.13.3.tar.xz
	cd freetype-2.13.3

	echoL "Building FreeType (2.13.3) Pass 1..."
	sleep 2
	#	tar -xf ../freetype-doc-2.13.3.tar.xz --strip-components=2 -C docs
	sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&
	sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&
	./configure --prefix=/usr --without-harfbuzz --disable-static && 
	make

	echoL "Installing FreeType (2.13.3) Pass 1..."
	sleep 2
	make install
	# If you downloaded the optional documentation, install it as the root user:
	#cp -v -R docs -T /usr/share/doc/freetype-2.13.3 &&
	#rm -v /usr/share/doc/freetype-2.13.3/freetype-config.1

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR freetype-2.13.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
