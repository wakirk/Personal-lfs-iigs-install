#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

  Acl (2.3.2) - 363 KB:
  Home page: https://savannah.nongnu.org/projects/acl
  Download: https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz
  MD5 sum: 590765dee95907dbc3c856f7255bd669
  echoR "System Software"

	echoL "Downloading Acl (2.3.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz acl-2.3.2.tar.xz
	cp ../Packages/-.tar.xz /sources

	echoL "Unpack Acl (2.3.2)..."
	sleep 2
	cd /sources
	rm -fR acl-2.3.2
	tar -vxsf acl-2.3.2.tar.xz
	cd acl-2.3.2

	echoL "Building Acl (2.3.2)..."
	sleep 2
  ./configure --prefix=/usr    \
              --disable-static \
            --docdir=/usr/share/doc/acl-2.3.2
make
	echoL "Testing Acl (2.3.2)..."
/bin/bash
# make check

	echoL "Installing Acl (2.3.2)..."
	sleep 2
make install

  
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR acl-2.3.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1












