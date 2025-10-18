# Expat (2.7.1) - 485 KB:
# Home page: https://libexpat.github.io/
# Download: https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz
# MD5 sum: 9f0c266ff4b9720beae0c6bd53ae4469


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




./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.7.1
make
make check
make install
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.7.1

