Intltool (0.51.0) - 159 KB:
Home page: https://freedesktop.org/wiki/Software/intltool

Download: https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz

MD5 sum: 12e517cac2b57a0121cda351570f1e63




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






8.45.1. Installation of Intltool
First fix a warning that is caused by perl-5.22 and later:

sed -i 's:\\\${:\\\$\\{:' intltool-update.in
[Note] Note
The above regular expression looks unusual because of all the backslashes. What it does is add a backslash before the right brace character in the sequence '\${' resulting in '\$\{'.

Prepare Intltool for compilation:

./configure --prefix=/usr
Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO
8.45.2. Contents of Intltool
