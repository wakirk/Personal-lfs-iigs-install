Elfutils (0.193) - 11,695 KB:
Home page: https://sourceware.org/elfutils/

Download: https://sourceware.org/ftp/elfutils/0.193/elfutils-0.193.tar.bz2

MD5 sum: ceefa052ded950a4c523688799193a44

Libelf from Elfutils (0.193)


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





8.49.1. Installation of Libelf
Libelf is part of the elfutils-0.193 package. Use the elfutils-0.193.tar.bz2 file as the source tarball.

Prepare Libelf for compilation:

./configure --prefix=/usr        \
            --disable-debuginfod \
            --enable-libdebuginfod=dummy
Compile the package:

make
To test the results, issue:

make check
Two tests are known to fail, dwarf_srclang_check and run-backtrace-native-core.sh.

Install only Libelf:

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a
8.49.2. Contents of Libelf




