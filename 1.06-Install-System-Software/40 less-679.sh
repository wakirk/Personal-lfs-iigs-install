Less (679) - 857 KB:
Home page: https://www.greenwoodsoftware.com/less/

Download: https://www.greenwoodsoftware.com/less/less-679.tar.gz

MD5 sum: 0386dc14f6a081a94dfb4c2413864eed



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






8.42.1. Installation of Less
Prepare Less for compilation:

./configure --prefix=/usr --sysconfdir=/etc
The meaning of the configure options:

--sysconfdir=/etc
This option tells the programs created by the package to look in /etc for the configuration files.

Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
8.42.2. Contents of Less





