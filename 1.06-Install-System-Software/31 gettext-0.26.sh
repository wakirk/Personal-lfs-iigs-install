#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

  # Gettext (0.26) - 9,926 KB:
  # Home page: https://www.gnu.org/software/gettext/
  # Download: https://ftp.gnu.org/gnu/gettext/gettext-0.26.tar.xz
  # MD5 sum: 8e14e926f088e292f5f2bce95b81d10e
	echoR "System Software"

	echoL "Downloading Gettext (0.26)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gettext/gettext-0.26.tar.xz gettext-0.26.tar.xz
	cp ../Packages/gettext-0.26.tar.xz /sources

	echoL "Unpack Gettext (0.26)..."
	sleep 2
	cd /sources
	rm -fR gettext-0.26
	tar -vxsf gettext-0.26.tar.xz
	cd gettext-0.26

	echoL "Building Gettext (0.26)..."
	sleep 2
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.26
make

	echoL "Testing Gettext (0.26)..."
  make check
  /bin/bash
  
	echoL "Installing Gettext (0.26)..."
	sleep 2
  make install
  chmod -v 0755 /usr/lib/preloadable_libintl.so

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR gettext-0.26

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1

