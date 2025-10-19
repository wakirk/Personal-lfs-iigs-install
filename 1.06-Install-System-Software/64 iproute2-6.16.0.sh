IPRoute2 (6.16.0) - 910 KB:
Home page: https://www.kernel.org/pub/linux/utils/net/iproute2/
Download: https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.16.0.tar.xz
MD5 sum: 80e1f91bf59d572acc15d5c6eb4f3e7c




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




8.66.1. Installation of IPRoute2
The arpd program included in this package will not be built since it depends on Berkeley DB, which is not installed in LFS. However, a directory and a man page for arpd will still be installed. Prevent this by running the commands shown below.

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8
Compile the package:

make NETNS_RUN_DIR=/run/netns
This package does not have a working test suite.

Install the package:

make SBINDIR=/usr/sbin install
If desired, install the documentation:

install -vDm644 COPYING README* -t /usr/share/doc/iproute2-6.16.0
8.66.2. Contents of IPRoute2
