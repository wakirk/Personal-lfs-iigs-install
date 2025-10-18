Wheel (0.46.1) - 54 KB:
Home page: https://pypi.org/project/wheel/

Download: https://pypi.org/packages/source/w/wheel/wheel-0.46.1.tar.gz

MD5 sum: 65e09ee84af36821e3b1e9564aa91bd5



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









8.54.1. Installation of Wheel
Compile Wheel with the following command:

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
Install Wheel with the following command:

pip3 install --no-index --find-links dist wheel
8.54.2. Contents of Wheel
