Procps (4.0.5) - 1,483 KB:
Home page: https://gitlab.com/procps-ng/procps/
Download: https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.5.tar.xz
MD5 sum: 90803e64f51f192f3325d25c3335d057



/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	Utils (5.8.1) - 1,428 KB:
	Home page: https://tukaani.org/xz
	Download: https: .tar.xz
	MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3
	echoR "System Software"

	echoL "Downloading ------- ( ) ..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://*.tar.xz *.tar.xz
	cp ../Packages/-.tar.xz /sources

	echoL "Unpack ------- ( ) ..."
	sleep 2
	cd /sources
	rm -fR
	tar -vxsf
	cd 

	echoL "Building ------- ( ) ..."
	sleep 2

	echoL "Testing ------- ( ) ..."
	sleep 2
	/bin/bash

	echoL "Installing ------- ( ) ..."
	sleep 2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR 

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1








8.78.1. Installation of Procps-ng
Prepare Procps-ng for compilation:

./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.5 \
            --disable-static                        \
            --disable-kill                          \
            --enable-watch8bit
The meaning of the configure option:

--disable-kill
This switch disables building the kill command; it will be installed from the Util-linux package.

--enable-watch8bit
This switch enables the ncursesw support for the watch command, so it can handle 8-bit characters.

Compile the package:

make
To run the test suite, run:

chown -R tester .
su tester -c "PATH=$PATH make check"
One test named ps with output flag bsdtime,cputime,etime,etimes is known to fail if the host kernel is not built with CONFIG_BSD_PROCESS_ACCT enabled. In addition, one pgrep test may fail in the chroot environment.

Install the package:

make install
8.78.2. Contents of Procps-ng





