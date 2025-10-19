Findutils (4.10.0) - 2,189 KB:
Home page: https://www.gnu.org/software/findutils/

Download: https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz

MD5 sum: 870cfd71c07d37ebe56f9f4aaf4ad872



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













8.62.1. Installation of Findutils
Prepare Findutils for compilation:

./configure --prefix=/usr --localstatedir=/var/lib/locate
The meaning of the configure options:

--localstatedir
This option moves the locate database to /var/lib/locate, which is the FHS-compliant location.

Compile the package:

make
To test the results, issue:

chown -R tester .
su tester -c "PATH=$PATH make check"
Install the package:

make install
8.62.2. Contents of Findutils






