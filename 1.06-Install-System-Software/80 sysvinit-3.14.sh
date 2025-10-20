SysVinit (3.14) - 236 KB:
Home page: https://savannah.nongnu.org/projects/sysvinit
Download: https://github.com/slicer69/sysvinit/releases/download/3.14/sysvinit-3.14.tar.xz
MD5 sum: bc6890b975d19dc9db42d0c7364dd092




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











8.82.1. Installation of SysVinit
First, apply a patch that removes several programs installed by other packages, clarifies a message, and fixes a compiler warning:

patch -Np1 -i ../sysvinit-3.14-consolidated-1.patch
Compile the package:

make
This package does not come with a test suite.

Install the package:

make install
8.82.2. Contents of SysVinit

