#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# libxml2 Dependencies
# 	Recommended
# 	ICU-77.1

# Optional
#	Valgrind-3.25.1 (may be used in the tests)

main () {

	# Download (HTTP): https://download.gnome.org/sources/libxml2/2.14/libxml2-2.14.5.tar.xz
	# Download MD5 sum: 59aac4e5d1d350ba2c4bddf1f7bc5098
	# Download size: 2.2 MB
	# Estimated disk space required: 100 MB (with tests)
	# Estimated build time: 0.3 SBU (Using parallelism=4; with tests)

	# Additional Downloads
	# Optional Test Suite: https://www.w3.org/XML/Test/xmlts20130923.tar.gz
	# This enables make check to do complete testing.
	echoR "Group 2 Support Library"

	echoL "Downloading libxml2 (2.14.5)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"
	../bash/Download.sh https://download.gnome.org/sources/libxml2/2.14/libxml2-2.14.5.tar.xz libxml2-2.14.5.tar.xz
	cp ../Packages/libxml2-2.14.5.tar.xz /sources

	../bash/Download.sh https://www.w3.org/XML/Test/xmlts20130923.tar.gz xmlts20130923.tar.gz
	cp ../Packages/xmlts20130923.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack libxml2 (2.14.5)..."
	sleep 2
	cd /sources
	rm -fR libxml2-2.14.5
	tar -vxsf libxml2-2.14.5.tar.xz
	cd libxml2-2.14.5

	echoL "Building libxml2 (2.14.5)..."
	sleep 2
	./configure --prefix=/usr   \
		--sysconfdir=/etc       \
		--disable-static        \
		--with-history          \
		--with-icu              \
		PYTHON=/usr/bin/python3 \
		--docdir=/usr/share/doc/libxml2-2.14.5 &&
	make

	echoL "Testing libxml2 (2.14.5)..."
	sleep 2
	tar xf ../xmlts20130923.tar.gz
	/etc/init.d/httpd stop
	make check-valgrind > check.log
	# This command will print several lines of error messages like “Failed to parse xstc/...”
	# because some test files are missing and these messages can be safely ignored.
	# A summary of the results can be obtained with 
	grep -E '^Total|expected|Ran' check.log 
	# If Valgrind-3.25.1 is installed and you want to check for memory leaks, replace
	# check with check-valgrind.

	echoL "Installing libxml2 (2.14.5)..."
	sleep 2
	make install
	rm -vf /usr/lib/libxml2.la
	sed '/libs=/s/xml2.*/xml2"/' -i /usr/bin/xml2-config

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR libxml2-2.14.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
