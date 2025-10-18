#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# XML::Parser (2.47) - 276 KB:
	# Home page: https://github.com/chorny/XML-Parser
	# Download: https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz
	# MD5 sum: 89a8e82cfd2ad948b349c0a69c494463
	echoR "System Software"

	echoL "Downloading XML::Parser (2.47)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz XML-Parser-2.47.tar.gz
	cp ../Packages/XML-Parser-2.47.tar.gz /sources

	echoL "Unpack XML::Parser (2.47)..."
	sleep 2
	cd /sources
	rm -fR XML-Parser-2.47
	tar -vxsf XML-Parser-2.47.tar.gz
	cd XML-Parser-2.47

	echoL "Building XML::Parser (2.47)..."
	sleep 2
	perl Makefile.PL
	make

	echoL "Testing XML::Parser (2.47)..."
	sleep 2
	make test

	echoL "Installing XML::Parser (2.47)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR XML-Parser-2.47

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
