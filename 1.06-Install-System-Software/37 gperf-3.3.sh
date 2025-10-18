Gperf (3.3) - 1,789 KB:
Home page: https://www.gnu.org/software/gperf/
Download: https://ftp.gnu.org/gnu/gperf/gperf-3.3.tar.gz
MD5 sum: 31753b021ea78a21f154bf9eecb8b079



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




8.39.1. Installation of Gperf
Prepare Gperf for compilation:

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.3
Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
8.39.2. Contents of Gperf
