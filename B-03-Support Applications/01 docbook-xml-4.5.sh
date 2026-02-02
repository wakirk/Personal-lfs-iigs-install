#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	libarchive-3.8.1
	#	libxml2-2.14.5

main () {

	# Download (HTTP): https://www.docbook.org/xml/4.5/docbook-xml-4.5.zip
	# Download MD5 sum: 03083e288e87a7e829e437358da7ef9e
	# Download size: 96 KB
	# Estimated disk space required: 1.2 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 3 Support Applications"

	echoL "Downloading docbook-xml (4.5)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://www.docbook.org/xml/4.5/docbook-xml-4.5.zip docbook-xml-4.5.zip
	cp ../Packages/docbook-xml-4.5.zip /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack docbook-xml (4.5)..."
	sleep 2
	cd /sources
	rm -fR docbook-xml-4.5
	mkdir docbook-xml-4.5
	cp -fv docbook-xml-4.5.zip docbook-xml-4.5
	cd docbook-xml-4.5
	unzip docbook-xml-4.5.zip

	echoL "Installing docbook-xml (4.5)..."
	sleep 2
	install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.5
	install -v -d -m755 /etc/xml
	cp -v -af --no-preserve=ownership docbook.cat *.dtd ent/ *.mod \
    /usr/share/xml/docbook/xml-dtd-4.5

	echoL "Configuring docbook-xml (4.5)..."
	sleep 2

	if [ ! -e /etc/xml/docbook ]; then
		xmlcatalog --noout --create /etc/xml/docbook
	fi

	xmlcatalog --noout --add "public"                            \
		"-//OASIS//DTD DocBook XML V4.5//EN"                     \
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                            \
		"-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN"    \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                            \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN"    \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                              \
		"-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod"    \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                                \
		"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod"      \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                            \
		"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN"    \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                           \
		"-//OASIS//ENTITIES DocBook XML Notations V4.5//EN"     \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                                \
		"-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod"      \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "public"                                         \
		"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod"              \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "rewriteSystem"        \
		"http://www.oasis-open.org/docbook/xml/4.5" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5" \
		/etc/xml/docbook &&

	xmlcatalog --noout --add "rewriteURI"           \
		"http://www.oasis-open.org/docbook/xml/4.5" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5" \
		/etc/xml/docbook

	# Create (or update) and populate the /etc/xml/catalog catalog file by running the following
	# commands as the root user:

	if [ ! -e /etc/xml/catalog ]; then
		xmlcatalog --noout --create /etc/xml/catalog
	fi

	xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//ENTITIES DocBook XML"      \
		"file:///etc/xml/docbook"             \
		/etc/xml/catalog

	xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//DTD DocBook XML"           \
		"file:///etc/xml/docbook"             \
		/etc/xml/catalog

	xmlcatalog --noout --add "delegateSystem" \
		"http://www.oasis-open.org/docbook/"  \
		"file:///etc/xml/docbook"             \
		/etc/xml/catalog

	xmlcatalog --noout --add "delegateURI"    \
		"http://www.oasis-open.org/docbook/"  \
		"file:///etc/xml/docbook"             \
		/etc/xml/catalog

	# Configuring DocBook-4.5 XML DTD
	# Config Files
	# /etc/xml/catalog and /etc/xml/docbook

	for DTDVERSION in 4.1.2 4.2 4.3 4.4
	do
		xmlcatalog --noout --add "public"                                \
		"-//OASIS//DTD DocBook XML V$DTDVERSION//EN"                     \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
		/etc/xml/docbook

		xmlcatalog --noout --add "rewriteSystem"            \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5"         \
		/etc/xml/docbook
  
		xmlcatalog --noout --add "rewriteURI"               \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5"         \
		/etc/xml/docbook
  
		xmlcatalog --noout --add "delegateSystem"            \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
		"file:///etc/xml/docbook"                            \
		/etc/xml/catalog
  
		xmlcatalog --noout --add "delegateURI"               \
		"http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
		"file:///etc/xml/docbook"                            \
		/etc/xml/catalog
	done

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR docbook-xml-4.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
