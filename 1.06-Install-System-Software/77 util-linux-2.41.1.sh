#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Util-linux (2.41.1) - 9,382 KB:
	# Home page: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/
	# Download: https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz
	# MD5 sum: 7e5e68845e2f347cf96f5448165f1764
	echoR "System Software"

	echoL "Downloading Util-linux (2.41.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz util-linux-2.41.1.tar.xz
	cp ../Packages/util-linux-2.41.1.tar.xz /sources

	echoL "Unpack Util-linux (2.41.1)..."
	sleep 2
	cd /sources
	rm -fR util-linux-2.41.1
	tar -vxsf util-linux-2.41.1.tar.xz
	cd util-linux-2.41.1

	echoL "Building Util-linux (2.41.1)..."
	sleep 2
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
	make

	echoL "Testing Util-linux (2.41.1)..."
	sleep 2
	bash tests/run.sh --srcdir=$PWD --builddir=$PWD
	touch /etc/fstab
	chown -R tester .
	su tester -c "make -k check"
	echo "Some tests are known to fail."
	/bin/bash

	echoL "Installing Util-linux (2.41.1)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR util-linux-2.41.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
