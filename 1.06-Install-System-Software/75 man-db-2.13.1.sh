Man-DB (2.13.1) - 2,061 KB:
Home page: https://www.nongnu.org/man-db/
Download: https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz
MD5 sum: b6335533cbeac3b24cd7be31fdee8c83




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










8.77.1. Installation of Man-DB
Prepare Man-DB for compilation:

./configure --prefix=/usr                         \
            --docdir=/usr/share/doc/man-db-2.13.1 \
            --sysconfdir=/etc                     \
            --disable-setuid                      \
            --enable-cache-owner=bin              \
            --with-browser=/usr/bin/lynx          \
            --with-vgrind=/usr/bin/vgrind         \
            --with-grap=/usr/bin/grap             \
            --with-systemdtmpfilesdir=            \
            --with-systemdsystemunitdir=
The meaning of the configure options:

--disable-setuid
This disables making the man program setuid to user man.

--enable-cache-owner=bin
This changes ownership of the system-wide cache files to user bin.

--with-...
These three parameters are used to set some default programs. lynx is a text-based web browser (see BLFS for installation instructions), vgrind converts program sources to Groff input, and grap is useful for typesetting graphs in Groff documents. The vgrind and grap programs are not normally needed for viewing manual pages. They are not part of LFS or BLFS, but you should be able to install them yourself after finishing LFS if you wish to do so.

--with-systemd...
These parameters prevent installing unneeded systemd directories and files.

Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
8.77.2. Non-English Manual Pages in LFS






