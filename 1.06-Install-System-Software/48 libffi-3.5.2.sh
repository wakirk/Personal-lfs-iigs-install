Libffi (3.5.2) - 1,390 KB:
Home page: https://sourceware.org/libffi/

Download: https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz

MD5 sum: 92af9efad4ba398995abf44835c5d9e9




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



bldLibffi() {
	echoL "Libffi (3.5.2)"
	echoR "Install System Software"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}




8.50.1. Installation of Libffi
[Note] Note
Like GMP, Libffi builds with optimizations specific to the processor in use. If building for another system, change the value of the --with-gcc-arch= parameter in the following command to an architecture name fully implemented by both the host CPU and the CPU on that system. If this is not done, all applications that link to libffi will trigger Illegal Operation Errors. If you cannot figure out a value safe for both the CPUs, replace the parameter with --without-gcc-arch to produce a generic library.

Prepare Libffi for compilation:

./configure --prefix=/usr    \
            --disable-static \
            --with-gcc-arch=native
The meaning of the configure option:

--with-gcc-arch=native
Ensure GCC optimizes for the current system. If this is not specified, the system is guessed and the code generated may not be correct. If the generated code will be copied from the native system to a less capable system, use the less capable system as a parameter. For details about alternative system types, see the x86 options in the GCC manual.

Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
8.50.2. Contents of Libffi
