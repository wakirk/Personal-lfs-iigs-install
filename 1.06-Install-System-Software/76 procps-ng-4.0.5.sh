#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Procps (4.0.5) - 1,483 KB:
	# Home page: https://gitlab.com/procps-ng/procps/
	# Download: https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.5.tar.xz
	# MD5 sum: 90803e64f51f192f3325d25c3335d057
	echoR "System Software"

	echoL "Downloading Procps (4.0.5)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.5.tar.xz procps-ng-4.0.5.tar.xz
	cp ../Packages/procps-ng-4.0.5.tar.xz /sources

	echoL "Unpack Procps (4.0.5)..."
	sleep 2
	cd /sources
	rm -fR procps-ng-4.0.5
	tar -vxsf procps-ng-4.0.5.tar.xz
	cd procps-ng-4.0.5

	echoL "Building Procps (4.0.5)..."
	sleep 2
	./configure --prefix=/usr                   \
		--docdir=/usr/share/doc/procps-ng-4.0.5 \
		--disable-static                        \
		--disable-kill                          \
		--enable-watch8bit
	make

	echoL "Testing Procps (4.0.5)..."
	sleep 2
	chown -R tester .
	su tester -c "PATH=$PATH make check"
	echo "One test named ps with output flag bsdtime,cputime,etime,etimes is known to fail if the host kernel"
	echo "is not built with CONFIG_BSD_PROCESS_ACCT enabled. In addition, one pgrep test may fail in the chroot environment."

	echoL "Installing Procps (4.0.5)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR procps-ng-4.0.5

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
