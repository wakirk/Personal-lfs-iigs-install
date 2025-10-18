Libtool (2.5.4) - 1,033 KB:
Home page: https://www.gnu.org/software/libtool/
Download: https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz
MD5 sum: 22e0a29df8af5fdde276ea3a7d351d30


8.37.1. Installation of Libtool
Prepare Libtool for compilation:

./configure --prefix=/usr
Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
Remove a static library only useful for the test suite:

rm -fv /usr/lib/libltdl.a
8.37.2. Contents of Libtool


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






