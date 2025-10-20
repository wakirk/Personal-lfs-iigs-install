#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Kbd (2.8.0) - 1,448 KB:
	# Home page: https://kbd-project.org/
	# Download: https://www.kernel.org/pub/linux/utils/kbd/kbd-2.8.0.tar.xz
	# MD5 sum: 24b5d24f7483726b88f214dc6c77aa41

	# Kbd Backspace/Delete Fix Patch - 12 KB:
	# Download: https://www.linuxfromscratch.org/patches/lfs/12.4/kbd-2.8.0-backspace-1.patch
	# MD5 sum: f75cca16a38da6caa7d52151f7136895
	echoR "System Software"

	echoL "Downloading Kbd (2.8.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/utils/kbd/kbd-2.8.0.tar.xz kbd-2.8.0.tar.xz
	cp ../Packages/kbd-2.8.0.tar.xz /sources
	../bash/Download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/kbd-2.8.0-backspace-1.patch kbd-2.8.0-backspace-1.patch
	cp ../Packages/kbd-2.8.0-backspace-1.patch /sources

	echoL "Unpack Kbd (2.8.0)..."
	sleep 2
	cd /sources
	rm -fR kbd-2.8.0
	tar -vxsf kbd-2.8.0.tar.xz
	cd kbd-2.8.0

	echoL "Building Kbd (2.8.0)..."
	sleep 2
	patch -Np1 -i ../kbd-2.8.0-backspace-1.patch
	sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
	sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
	./configure --prefix=/usr --disable-vlock
	make
	
	echoL "Installing Kbd (2.8.0)..."
	sleep 2
	make install
	cp -R -v docs/doc -T /usr/share/doc/kbd-2.8.0

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR kbd-2.8.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
