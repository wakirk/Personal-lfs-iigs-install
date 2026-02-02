#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Recommended (at runtime)
	# 	libxml2-2.14.5

	# Optional (all used at runtime)
	# 	apache-ant-1.10.15 (to produce “webhelp” documents)
	# 	libxslt-1.1.43 (or any other XSLT processor) to process Docbook documents,
	# 	Ruby-3.4.5 (to utilize the “epub” stylesheets), 
	# 	Zip-3.0 (to produce “epub3” documents),
	# 	Saxon6 and Xerces2 Java (used with apache-ant-1.10.15 to produce “webhelp” documents)

main () {

	# Download (HTTP): https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-nons-1.79.2.tar.bz2
	# Download MD5 sum: 2666d1488d6ced1551d15f31d7ed8c38
	# Download size: 22 MB
	# Estimated disk space required: 58 MB (includes installing optional documentation)
	# Estimated build time: less than 0.1 SBU

	# Additional Downloads
	# Required patch: https://www.linuxfromscratch.org/patches/blfs/12.4/docbook-xsl-nons-1.79.2-stack_fix-1.patch

	# Optional documentation
	# Download (HTTP): https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-doc-1.79.2.tar.bz2
	# Download MD5 sum: 62375ca864fc198cb2b17d98209d0b8c
	# Download size: 522 KB
	echoR "Group 3 Support Applications"

	echoL "Downloading docbook-xsl-nons (1.79.2)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-nons-1.79.2.tar.bz2 docbook-xsl-nons-1.79.2.tar.bz2
	cp ../Packages/docbook-xsl-nons-1.79.2.tar.bz2 /sources
	../bash/Download.sh https://www.linuxfromscratch.org/patches/blfs/12.4/docbook-xsl-nons-1.79.2-stack_fix-1.patch docbook-xsl-nons-1.79.2-stack_fix-1.patch
	cp ../Packages/docbook-xsl-nons-1.79.2-stack_fix-1.patch /sources
	../bash/Download.sh https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-doc-1.79.2.tar.bz2 docbook-xsl-doc-1.79.2.tar.bz2
	cp ../Packages/docbook-xsl-doc-1.79.2.tar.bz2 /sources


	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack docbook-xsl-nons (1.79.2)..."
	sleep 2
	cd /sources
	rm -fR docbook-xsl-nons-1.79.2
	tar -vxsf docbook-xsl-nons-1.79.2.tar.bz2
	cd docbook-xsl-nons-1.79.2

	echoL "Installing docbook-xsl-nons (1.79.2)..."
	sleep 2
	patch -Np1 -i ../docbook-xsl-nons-1.79.2-stack_fix-1.patch
	tar -vxf ../docbook-xsl-doc-1.79.2.tar.bz2 --strip-components=1
	install -v -m755 -d /usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2
	cp -v -R VERSION assembly common eclipse epub epub3 extensions fo   \
		highlighting html htmlhelp images javahelp lib manpages params  \
		profiling roundtrip slides template tests tools webhelp website \
		xhtml xhtml-1_1 xhtml5                                          \
		/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2
	ln -s VERSION /usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2/VERSION.xsl
	install -v -m644 -D README /usr/share/doc/docbook-xsl-nons-1.79.2/README.txt
	install -v -m644    RELEASE-NOTES* NEWS* /usr/share/doc/docbook-xsl-nons-1.79.2
	cp -v -R doc/* /usr/share/doc/docbook-xsl-nons-1.79.2

	echoL "Configuring docbook-xsl-nons (1.79.2)..."
	sleep 2
	if [ ! -d /etc/xml ]; then install -v -m755 -d /etc/xml; fi
	if [ ! -f /etc/xml/catalog ]; then
		xmlcatalog --noout --create /etc/xml/catalog
	fi
	xmlcatalog --noout --add "rewriteSystem"                 \
		"http://cdn.docbook.org/release/xsl-nons/1.79.2"     \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteSystem"                 \
		"https://cdn.docbook.org/release/xsl-nons/1.79.2"    \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteURI"                    \
		"http://cdn.docbook.org/release/xsl-nons/1.79.2"     \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteURI"                    \
		"https://cdn.docbook.org/release/xsl-nons/1.79.2"    \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteSystem"                 \
		"http://cdn.docbook.org/release/xsl-nons/current"    \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteSystem"                 \
		"https://cdn.docbook.org/release/xsl-nons/current"   \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteURI"                    \
		"http://cdn.docbook.org/release/xsl-nons/current"    \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteURI"                    \
		"https://cdn.docbook.org/release/xsl-nons/current"   \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteSystem"                 \
		"http://docbook.sourceforge.net/release/xsl/current" \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteURI"                    \
		"http://docbook.sourceforge.net/release/xsl/current" \
		"/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteSystem"                   \
		"http://docbook.sourceforge.net/release/xsl/<version>" \
		"/usr/share/xml/docbook/xsl-stylesheets-<version>"     \
		/etc/xml/catalog
	xmlcatalog --noout --add "rewriteURI"                      \
		"http://docbook.sourceforge.net/release/xsl/<version>" \
		"/usr/share/xml/docbook/xsl-stylesheets-<version>"     \
		/etc/xml/catalog

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR docbook-xsl-nons-1.79.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
