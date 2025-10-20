MarkupSafe (3.0.2) - 21 KB:
Home page: https://palletsprojects.com/p/markupsafe/
Download: https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.2.tar.gz
MD5 sum: cb0071711b573b155cc8f86e1de72167







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






8.74.1. Installation of MarkupSafe
Compile MarkupSafe with the following command:

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
This package does not come with a test suite.

Install the package:

pip3 install --no-index --find-links dist Markupsafe
8.74.2. Contents of MarkupSafe



