#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Fontconfig Dependencies
	#	Required
	#	FreeType-2.13.3

	# Optional
	#	bubblewrap-0.11.0 (used by some tests)
	#	cURL-8.15.0
	#	libarchive-3.8.1 (both used by some tests for downloading and extracting test files)
	#	JSON-C-0.18
	#	DocBook-utils-0.6.14
	#	libxml2-2.14.5
	#	texlive-20250308 (or install-tl-unx)

main () {

	# Download (HTTP): https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/2.17.1/fontconfig-2.17.1.tar.xz
	# Download MD5 sum: f68f95052c7297b98eccb7709d817f6a
	# Download size: 1.3 MB
	# Estimated disk space required: 18 MB (with tests)
	# Estimated build time: 0.4 SBU (with tests)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Fontconfig (2.17.1)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/2.17.1/fontconfig-2.17.1.tar.xz fontconfig-2.17.1.tar.xz
	cp ../Packages/fontconfig-2.17.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Fontconfig (2.17.1)..."
	sleep 2
	cd /sources
	rm -fR fontconfig-2.17.1
	tar -vxsf fontconfig-2.17.1.tar.xz
	cd fontconfig-2.17.1

	echoL "Building Fontconfig (2.17.1)..."
	sleep 2
	./configure --prefix=/usr        \
				--sysconfdir=/etc    \
				--localstatedir=/var \
				--disable-docs       \
	--docdir=/usr/share/doc/fontconfig-2.17.1 &&
	make

	echoL "Testing Fontconfig (2.17.1)..."
	sleep 2
	make check

	echoL "Installing Fontconfig (2.17.1)..."
	sleep 2
	make install
	install -v -dm755 /usr/share/{man/man{1,3,5},doc/fontconfig-2.17.1}
	install -v -m644 fc-*/*.1         /usr/share/man/man1
	install -v -m644 doc/*.3          /usr/share/man/man3
	install -v -m644 doc/fonts-conf.5 /usr/share/man/man5
	install -v -m644 doc/*.{pdf,sgml,txt,html} /usr/share/doc/fontconfig-2.17.1

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR fontconfig-2.17.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
