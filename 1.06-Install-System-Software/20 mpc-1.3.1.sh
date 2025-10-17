#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

  # MPC (1.3.1) - 756 KB:
  # Home page: https://www.multiprecision.org/
  # Download: https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
  # MD5 sum: 5c9bc658c9fd0f940e8e3e0f09530c62
	echoR "System Software"

	echoL "Downloading MPC (1.3.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz mpc-1.3.1.tar.gz
	cp ../Packages/mpc-1.3.1.tar.gz /sources

	echoL "Unpack MPC (1.3.1)..."
	sleep 2
	cd /sources
	rm -fR mpc-1.3.1
	tar -vxsf mpc-1.3.1.tar.gz
	cd mpc-1.3.1

	echoL "Building MPC (1.3.1)..."
	sleep 2
  ./configure --prefix=/usr \
    --disable-static        \
    --docdir=/usr/share/doc/mpc-1.3.1
  make
  make html

	echoL "Building MPC (1.3.1)..."
	sleep 2
  /bin/bash
  # make check

	echoL "Installing MPC (1.3.1)..."
	sleep 2
  make install
  make install-html

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR mpc-1.3.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1


