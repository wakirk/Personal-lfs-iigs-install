



/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

Packaging (25.0) - 162 KB:
Home page: https://pypi.org/project/packaging/

Download: https://files.pythonhosted.org/packages/source/p/packaging/packaging-25.0.tar.gz

MD5 sum: ab0ef21ddebe09d1803575120d3f99f8

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

8.53. Packaging-25.0
The packaging module is a Python library that provides utilities that implement the interoperability specifications which have clearly one correct behaviour (PEP440) or benefit greatly from having a single shared implementation (PEP425). This includes utilities for version handling, specifiers, markers, tags, and requirements.

Approximate build time:
less than 0.1 SBU
Required disk space:
3.3 MB
8.53.1. Installation of Packaging
Compile packaging with the following command:

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
Install packaging with the following command:

pip3 install --no-index --find-links dist packaging
8.53.2. Contents of Packaging

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



