#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# SQLite Dependencies
	# 	Optional
	# 	libarchive-3.8.1 (required to unzip the documentation) and libedit

main () {

	# Download (HTTP): https://sqlite.org/2025/sqlite-autoconf-3500400.tar.gz
	# Download MD5 sum: d74bbdca4ab1b2bd46d3b3f8dbb0f3db
	# Download size: 3.0 MB
	# Estimated disk space required: 44 MB (with documentation)
	# Estimated build time: 0.1 SBU (Using parallelism=4)

	# Additional Downloads
	# Optional Documentation
	# Download (HTTP): https://sqlite.org/2025/sqlite-doc-3500400.zip
	# Download MD5 sum: faa12e794bcc37ba275fd6268317eb87
	echoR "Group 1 Library Foundation"

	echoL "Downloading SQLite (3.50.4)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://sqlite.org/2025/sqlite-autoconf-3500400.tar.gz sqlite-autoconf-3500400.tar.gz
	cp ../Packages/sqlite-autoconf-3500400.tar.gz /sources

	../bash/Download.sh https://sqlite.org/2025/sqlite-doc-3500400.zip sqlite-doc-3500400.zip
	cp ../Packages/sqlite-doc-3500400.zip /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack SQLite (3.50.4)..."
	sleep 2
	cd /sources
	rm -fR 
	tar -vxsf sqlite-autoconf-3500400.tar.gz
	cd sqlite-autoconf-3500400

	echoL "Building SQLite (3.50.4)..."
	sleep 2
	unzip -q ../sqlite-doc-3500400.zip
	./configure --prefix=/usr --disable-static --enable-fts{4,5} \
	  CPPFLAGS="-D SQLITE_ENABLE_COLUMN_METADATA=1 \
				-D SQLITE_ENABLE_UNLOCK_NOTIFY=1   \
				-D SQLITE_ENABLE_DBSTAT_VTAB=1     \
				-D SQLITE_SECURE_DELETE=1"        && 
	make

	echoL "Installing SQLite (3.50.4)..."
	sleep 2
	make install
	install -v -m755 -d /usr/share/doc/sqlite-3.50.4
	cp -v -R sqlite-doc-3500400/* /usr/share/doc/sqlite-3.50.4

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR sqlite-autoconf-3500400

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
