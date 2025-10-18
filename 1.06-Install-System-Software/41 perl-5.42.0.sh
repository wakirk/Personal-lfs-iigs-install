#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Perl (5.42.0) - 14,084 KB:
	# Home page: https://www.perl.org/
	# Download: https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
	# MD5 sum: 7a6950a9f12d01eb96a9d2ed2f4e0072
	echoR "System Software"

	echoL "Downloading Perl (5.42.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz perl-5.42.0.tar.xz
	cp ../Packages/perl-5.42.0.tar.xz /sources

	echoL "Unpack Perl (5.42.0)..."
	sleep 2
	cd /sources
	rm -fR perl-5.42.0
	tar -vxsf perl-5.42.0.tar.xz
	cd perl-5.42.0

	echoL "Building Perl (5.42.0)..."
	sleep 2
	export BUILD_ZLIB=False
	export BUILD_BZIP2=0
	sh Configure -des                                 \
		-D prefix=/usr                                \
		-D vendorprefix=/usr                          \
		-D privlib=/usr/lib/perl5/5.42/core_perl      \
		-D archlib=/usr/lib/perl5/5.42/core_perl      \
		-D sitelib=/usr/lib/perl5/5.42/site_perl      \
		-D sitearch=/usr/lib/perl5/5.42/site_perl     \
		-D vendorlib=/usr/lib/perl5/5.42/vendor_perl  \
		-D vendorarch=/usr/lib/perl5/5.42/vendor_perl \
		-D man1dir=/usr/share/man/man1                \
		-D man3dir=/usr/share/man/man3                \
		-D pager="/usr/bin/less -isR"                 \
		-D useshrplib                                 \
		-D usethreads
	make

	echoL "Testing Perl (5.42.0)..."
	sleep 2
	TEST_JOBS=$(nproc) make test_harness

	echoL "Installing Perl (5.42.0)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	unset BUILD_ZLIB BUILD_BZIP2
	cd /sources
	rm -fR perl-5.42.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
