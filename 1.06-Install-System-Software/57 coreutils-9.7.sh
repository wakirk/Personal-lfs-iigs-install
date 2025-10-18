Coreutils (9.7) - 6,015 KB:
Home page: https://www.gnu.org/software/coreutils/
Download: https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz
MD5 sum: 6b7285faf7d5eb91592bdd689270d3f1

Coreutils Upstream Fix Patch - 4.1 KB:
Download: https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-upstream_fix-1.patch
MD5 sum: 96382a5aa85d6651a74f94ffb61785d9

Coreutils Internationalization Fixes Patch - 159 KB:
Download: https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-i18n-1.patch
MD5 sum: 33ebfad32b2dfb8417c3335c08671206




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




8.59.1. Installation of Coreutils
First, apply a patch for a security problem identified upstream:

patch -Np1 -i ../coreutils-9.7-upstream_fix-1.patch
POSIX requires that programs from Coreutils recognize character boundaries correctly even in multibyte locales. The following patch fixes this non-compliance and other internationalization-related bugs.

patch -Np1 -i ../coreutils-9.7-i18n-1.patch
[Note] Note
Many bugs have been found in this patch. When reporting new bugs to the Coreutils maintainers, please check first to see if those bugs are reproducible without this patch.

Now prepare Coreutils for compilation:

autoreconf -fv
automake -af
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime
The meaning of the commands and configure options:

autoreconf -fv
The patch for internationalization has modified the build system, so the configuration files must be regenerated. Normally we would use the -i option to update the standard auxiliary files, but for this package it does not work because configure.ac specified an old gettext version.

automake -af
The automake auxiliary files were not updated by autoreconf due to the missing -i option. This command updates them to prevent a build failure.

FORCE_UNSAFE_CONFIGURE=1
This environment variable allows the package to be built by the root user.

--enable-no-install-program=kill,uptime
The purpose of this switch is to prevent Coreutils from installing programs that will be installed by other packages.

Compile the package:

make
Skip down to “Install the package” if not running the test suite.

Now the test suite is ready to be run. First, run the tests that are meant to be run as user root:

make NON_ROOT_USERNAME=tester check-root
We're going to run the remainder of the tests as the tester user. Certain tests require that the user be a member of more than one group. So that these tests are not skipped, add a temporary group and make the user tester a part of it:

groupadd -g 102 dummy -U tester
Fix some of the permissions so that the non-root user can compile and run the tests:

chown -R tester . 
Now run the tests (using /dev/null for the standard input, or two tests may be broken if building LFS in a graphical terminal or a session in SSH or GNU Screen because the standard input is connected to a PTY from host distro, and the device node for such a PTY cannot be accessed from the LFS chroot environment):

su tester -c "PATH=$PATH make -k RUN_EXPENSIVE_TESTS=yes check" \
   < /dev/null
Remove the temporary group:

groupdel dummy
Install the package:

make install
Move programs to the locations specified by the FHS:

mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8
8.59.2. Contents of Coreutils



