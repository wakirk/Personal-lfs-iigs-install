Util-linux (2.41.1) - 9,382 KB:
Home page: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/
Download: https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz
MD5 sum: 7e5e68845e2f347cf96f5448165f1764



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
















8.79.1. Installation of Util-linux
Prepare Util-linux for compilation:

./configure --bindir=/usr/bin     \
            --libdir=/usr/lib     \
            --runstatedir=/run    \
            --sbindir=/usr/sbin   \
            --disable-chfn-chsh   \
            --disable-login       \
            --disable-nologin     \
            --disable-su          \
            --disable-setpriv     \
            --disable-runuser     \
            --disable-pylibmount  \
            --disable-liblastlog2 \
            --disable-static      \
            --without-python      \
            --without-systemd     \
            --without-systemdsystemunitdir        \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.41.1
The --disable and --without options prevent warnings about building components that either require packages not in LFS, or are inconsistent with programs installed by other packages.

Compile the package:

make
If desired, create a dummy /etc/fstab file to satisfy two tests and run the test suite as a non-root user:

[Warning] Warning
Running the test suite as the root user can be harmful to your system. To run it, the CONFIG_SCSI_DEBUG option for the kernel must be available in the currently running system and must be built as a module. Building it into the kernel will prevent booting. For complete coverage, other BLFS packages must be installed. If desired, this test can be run by booting into the completed LFS system and running:

bash tests/run.sh --srcdir=$PWD --builddir=$PWD
touch /etc/fstab
chown -R tester .
su tester -c "make -k check"
The hardlink tests will fail if the host's kernel does not have the option CONFIG_CRYPTO_USER_API_HASH enabled or does not have any options providing a SHA256 implementation (for example, CONFIG_CRYPTO_SHA256, or CONFIG_CRYPTO_SHA256_SSSE3 if the CPU supports Supplemental SSE3) enabled. In addition, the lsfd: inotify test will fail if the kernel option CONFIG_NETLINK_DIAG is not enabled.

One test, kill: decode functions, is known to fail with bash-5.3-rc1 or newer.

Install the package:

make install
8.79.2. Contents of Util-linux








