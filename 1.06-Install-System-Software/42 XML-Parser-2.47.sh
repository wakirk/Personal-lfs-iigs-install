XML::Parser (2.47) - 276 KB:
Home page: https://github.com/chorny/XML-Parser

Download: https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz

MD5 sum: 89a8e82cfd2ad948b349c0a69c494463



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






8.44.1. Installation of XML::Parser
Prepare XML::Parser for compilation:

perl Makefile.PL
Compile the package:

make
To test the results, issue:

make test
Install the package:

make install
8.44.2. Contents of XML::Parser
