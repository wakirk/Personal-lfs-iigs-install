#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

  Psmisc (23.7) - 423 KB:
  Home page: https://gitlab.com/psmisc/psmisc
  Download: https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz
  MD5 sum: 53eae841735189a896d614cba440eb10
	echoR "System Software"

	echoL "Downloading Psmisc (23.7)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz psmisc-23.7.tar.xz
	cp ../Packages/psmisc-23.7.tar.xz /sources

	echoL "Unpack Psmisc (23.7)..."
	sleep 2
	cd /sources
	rm -fR psmisc-23.7
	tar -vxsf psmisc-23.7.tar.xz
	cd psmisc-23.7

	echoL "Building Psmisc (23.7)..."
	sleep 2
  ./configure --prefix=/usr
  make

	echoL "Testing Psmisc (23.7)..."
	sleep 2
  make check
  /bin/bash

	echoL "Installing Psmisc (23.7)..."
	sleep 2
  make install

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR psmisc-23.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
