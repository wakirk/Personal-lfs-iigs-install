Grep (3.12) - 1,874 KB:
Home page: https://www.gnu.org/software/grep/

Download: https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz

MD5 sum: 5d9301ed9d209c4a88c8d3a6fd08b9ac






/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	Utils (5.8.1) - 1,428 KB:
	Home page: https://tukaani.org/xz
	Download: https: .tar.xz
	MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3
	echoR "System Software"

	echoL "Downloading Grep (3.12)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz grep-3.12.tar.xz
	cp ../Packages/grep-3.12.tar.xz /sources

	echoL "Unpack Grep (3.12)..."
	sleep 2
	cd /sources
	rm -fR grep-3.12
	tar -vxsf grep-3.12.tar.xz
	cd grep-3.12

	echoL "Building Grep (3.12)..."
	sleep 2
  sed -i "s/echo/#echo/" src/egrep.sh
  ./configure --prefix=/usr
  make




  echoL "Testing Grep (3.12)..."
	sleep 2
make check

  
	echoL "Installing Grep (3.12)..."
	sleep 2
make install

  
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR grep-3.12

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1



