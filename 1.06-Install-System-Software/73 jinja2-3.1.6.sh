Jinja2 (3.1.6) - 240 KB:
Home page: https://jinja.palletsprojects.com/en/3.1.x/
Download: https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz
MD5 sum: 66d4c25ff43d1deaf9637ccda523dec8




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




8.75.1. Installation of Jinja2
Build the package:

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
Install the package:

pip3 install --no-index --find-links dist Jinja2
8.75.2. Contents of Jinja2






