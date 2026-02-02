#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Coreutils (9.7) - 6,015 KB:
	# Home page: https://www.gnu.org/software/coreutils/
	# Download: https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz
	# MD5 sum: 6b7285faf7d5eb91592bdd689270d3f1

	# Coreutils Upstream Fix Patch - 4.1 KB:
	# Download: https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-upstream_fix-1.patch
	# MD5 sum: 96382a5aa85d6651a74f94ffb61785d9

	# Coreutils Internationalization Fixes Patch - 159 KB:
	# Download: https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-i18n-1.patch
	# MD5 sum: 33ebfad32b2dfb8417c3335c08671206
	echoR "System Software"

	echoL "Downloading Coreutils (9.7)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz coreutils-9.7.tar.xz
	cp ../Packages/coreutils-9.7.tar.xz /sources

	../bash/Download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-upstream_fix-1.patch coreutils-9.7-upstream_fix-1.patch
	cp ../Packages/coreutils-9.7-upstream_fix-1.patch /sources

	../bash/Download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-i18n-1.patch coreutils-9.7-i18n-1.patch
	cp ../Packages/coreutils-9.7-i18n-1.patch /sources

	echoL "Unpack Coreutils (9.7)..."
	sleep 2
	cd /sources
	rm -fR coreutils-9.7
	tar -vxsf coreutils-9.7.tar.xz
	cd coreutils-9.7

	echoL "Building Coreutils (9.7)..."
	sleep 2
	patch -Np1 -i ../coreutils-9.7-upstream_fix-1.patch
	patch -Np1 -i ../coreutils-9.7-i18n-1.patch
	autoreconf -fv
	automake -af
	FORCE_UNSAFE_CONFIGURE=1 ./configure \
	--prefix=/usr                        \
	--enable-no-install-program=kill,uptime
	make

	echoL "Testing Coreutils (9.7)..."
	sleep 2
	make NON_ROOT_USERNAME=tester check-root
	groupadd -g 102 dummy -U tester
	chown -R tester . 
	su tester -c "PATH=$PATH make -k RUN_EXPENSIVE_TESTS=yes check" < /dev/null
	groupdel dummy

	echoL "Installing Coreutils (9.7)..."
	sleep 2
	make install
	mv -v /usr/bin/chroot /usr/sbin
	mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
	sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR coreutils-9.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
