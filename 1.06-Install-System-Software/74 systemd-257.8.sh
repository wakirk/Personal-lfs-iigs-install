#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Systemd (257.8) - 16,002 KB:
	# Home page: https://www.freedesktop.org/wiki/Software/systemd/
	# Download: https://github.com/systemd/systemd/archive/v257.8/systemd-257.8.tar.gz
	# MD5 sum: 25fe5d328e22641254761f1baa74cee0

	# Systemd Man Pages (257.8) - 736 KB:
	# Home page: https://www.freedesktop.org/wiki/Software/systemd/
	# Download: https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-257.8.tar.xz
	# MD5 sum: a44063e2ec0cf4adfd2ed5c9e9e095c5

	# Udev-lfs Tarball (udev-lfs-20230818) - 10 KB:
	# Download: https://anduin.linuxfromscratch.org/LFS/udev-lfs-20230818.tar.xz
	# MD5 sum: acd4360d8a5c3ef320b9db88d275dae6
	echoR "System Software"

	echoL "Downloading udev from Systemd (257.8)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/systemd/systemd/archive/v257.8/systemd-257.8.tar.gz systemd-257.8.tar.gz
	cp ../Packages/systemd-257.8.tar.gz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-257.8.tar.xz systemd-man-pages-257.8.tar.xz
	cp ../Packages/systemd-man-pages-257.8.tar.xz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/LFS/udev-lfs-20230818.tar.xz udev-lfs-20230818.tar.xz
	cp ../Packages/udev-lfs-20230818.tar.xz /sources

	echoL "Unpack udev from Systemd (257.8)..."
	sleep 2
	cd /sources
	rm -fR systemd-257.8
	tar -vxsf systemd-257.8.tar.gz
	cd systemd-257.8

	echoL "Building udev from Systemd (257.8)..."
	sleep 2
	sed -e 's/GROUP="render"/GROUP="video"/' \
	-e 's/GROUP="sgx", //'                   \
	-i rules.d/50-udev-default.rules.in
	sed -i '/systemd-sysctl/s/^/#/' rules.d/99-systemd.rules.in
	sed -e '/NETWORK_DIRS/s/systemd/udev/' \
	-i src/libsystemd/sd-network/network-util.h
	mkdir -p build
	cd       build
	meson setup ..                \
		--prefix=/usr             \
		--buildtype=release       \
		-D mode=release           \
		-D dev-kvm-mode=0660      \
		-D link-udev-shared=false \
		-D logind=false           \
		-D vconsole=false
	export udev_helpers=$(grep "'name' :" ../src/udev/meson.build | \
	awk '{print $3}' | tr -d ",'" | grep -v 'udevadm')
	ninja udevadm systemd-hwdb                                         \
		$(ninja -n | grep -Eo '(src/(lib)?udev|rules.d|hwdb.d)/[^ ]*') \
		$(realpath libudev.so --relative-to .)                         \
		$udev_helpers

	echoL "Installing udev from Systemd (257.8)..."
	sleep 2
	install -vm755 -d {/usr/lib,/etc}/udev/{hwdb.d,rules.d,network}
	install -vm755 -d /usr/{lib,share}/pkgconfig
	install -vm755 udevadm                             /usr/bin/
	install -vm755 systemd-hwdb                        /usr/bin/udev-hwdb
	ln      -svfn  ../bin/udevadm                      /usr/sbin/udevd
	cp      -av    libudev.so{,*[0-9]}                 /usr/lib/
	install -vm644 ../src/libudev/libudev.h            /usr/include/
	install -vm644 src/libudev/*.pc                    /usr/lib/pkgconfig/
	install -vm644 src/udev/*.pc                       /usr/share/pkgconfig/
	install -vm644 ../src/udev/udev.conf               /etc/udev/
	install -vm644 rules.d/* ../rules.d/README         /usr/lib/udev/rules.d/
	install -vm644 $(find ../rules.d/*.rules -not -name '*power-switch*') /usr/lib/udev/rules.d/
	install -vm644 hwdb.d/*  ../hwdb.d/{*.hwdb,README} /usr/lib/udev/hwdb.d/
	install -vm755 $udev_helpers                       /usr/lib/udev
	install -vm644 ../network/99-default.link          /usr/lib/udev/network

	tar -xvf ../../udev-lfs-20230818.tar.xz
	make -f udev-lfs-20230818/Makefile.lfs install

	tar -xf ../../systemd-man-pages-257.8.tar.xz           \
	--no-same-owner --strip-components=1                   \
	-C /usr/share/man --wildcards 	'*/udev*' '*/libudev*' \
								 	'*/systemd.link.5'     \
								 	'*/systemd-'{hwdb,udevd.service}.8

	sed 's|systemd/network|udev/network|'    \
		/usr/share/man/man5/systemd.link.5   \
		> /usr/share/man/man5/udev.link.5

	sed 's/systemd\(\\\?-\)/udev\1/'        \
		/usr/share/man/man8/systemd-hwdb.8  \
		> /usr/share/man/man8/udev-hwdb.8

	sed 's|lib.*udevd|sbin/udevd|'               \
    /usr/share/man/man8/systemd-udevd.service.8  \
  > /usr/share/man/man8/udevd.8

	rm /usr/share/man/man*/systemd*
	unset udev_helpers
	udev-hwdb update
	
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR systemd-257.8

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
