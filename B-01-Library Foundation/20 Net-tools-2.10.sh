#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Installation of Net-tools

	# The instructions below automate the configuration process by piping yes to the make command.
	# If you wish to run the interactive configuration process (by changing the instruction to just make),
	# but you are not sure how to answer all the questions, then just accept the defaults.
	# This will be just fine in the majority of cases. What you're asked here is a bunch of
	# questions about which network protocols you've enabled in your kernel. The default answers
	# will enable the tools from this package to work with the most common protocols: TCP, PPP,
	# and several others. You still need to actually enable these protocols in the kernel—what
	# you do here is merely tell the package to include support for those protocols in its programs,
	# but it's up to the kernel to make the protocols available.

	# [Note] Note
	# This package has several unneeded protocols and hardware device specific functions that
	# are obsolete. To only build the minimum needed for your system, skip the yes command and
	# answer each question interactively. The minimum needed options are 'UNIX protocol family'
	# and 'INET (TCP/IP) protocol family'.

	# For this package, we use the DESTDIR method of installation in order to easily remove
	# files from the build that overwrite those that we want to keep or are not appropriate for
	# our system.


main () {

	# Download (HTTP): https://downloads.sourceforge.net/project/net-tools/net-tools-2.10.tar.xz
	# Download MD5 sum: 78aae762c95e2d731faf88d482e4cde5
	# Download size: 228 KB
	# Estimated disk space required: 7.5 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading Net-tools (2.10)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://downloads.sourceforge.net/project/net-tools/net-tools-2.10.tar.xz net-tools-2.10.tar.xz
	cp ../Packages/net-tools-2.10.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Net-tools (2.10)..."
	sleep 2
	cd /sources
	rm -fR net-tools-2.10
	tar -vxsf net-tools-2.10.tar.xz
	cd net-tools-2.10

	echoL "Building Net-tools (2.10)..."
	sleep 2
	export BINDIR='/usr/bin' SBINDIR='/usr/bin'
	yes "" | make -j1
	make DESTDIR=$PWD/install -j1 install
	rm    install/usr/bin/{nis,yp}domainname
	rm    install/usr/bin/{hostname,dnsdomainname,domainname,ifconfig}
	rm -r install/usr/share/man/man1
	rm    install/usr/share/man/man8/ifconfig.8
	unset BINDIR SBINDIR

	echoL "Installing Net-tools (2.10)..."
	sleep 2
	chown -R root:root install
	cp -va install/* /

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR net-tools-2.10

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
