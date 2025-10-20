#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# SysVinit (3.14) - 236 KB:
	# Home page: https://savannah.nongnu.org/projects/sysvinit
	# Download: https://github.com/slicer69/sysvinit/releases/download/3.14/sysvinit-3.14.tar.xz
	# MD5 sum: bc6890b975d19dc9db42d0c7364dd092

	# SysVinit Consolidated Patch - 2.5 KB:
	# Download: https://www.linuxfromscratch.org/patches/lfs/12.4/sysvinit-3.14-consolidated-1.patch
	# MD5 sum: 3af8fd8e13cad481eeeaa48be4247445
	echoR "System Software"

	echoL "Downloading SysVinit (3.14)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/slicer69/sysvinit/releases/download/3.14/sysvinit-3.14.tar.xz sysvinit-3.14.tar.xz
	cp ../Packages/sysvinit-3.14.tar.xz /sources

	../bash/Download.sh https://www.linuxfromscratch.org/patches/lfs/12.4/sysvinit-3.14-consolidated-1.patch sysvinit-3.14-consolidated-1.patch
	cp ../Packages/sysvinit-3.14-consolidated-1.patch /sources

	echoL "Unpack SysVinit (3.14)..."
	sleep 2
	cd /sources
	rm -fR sysvinit-3.14
	tar -vxsf sysvinit-3.14.tar.xz
	cd sysvinit-3.14

	echoL "Building SysVinit (3.14)..."
	sleep 2
	patch -Np1 -i ../sysvinit-3.14-consolidated-1.patch
	make

	echoL "Installing SysVinit (3.14)..."
	sleep 2
	make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR sysvinit-3.14

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
