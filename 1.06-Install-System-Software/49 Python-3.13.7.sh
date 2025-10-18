#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Python (3.13.7) - 22,236 KB:
	# Home page: https://www.python.org/
	# Download: https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz
	# MD5 sum: 256cdb3bbf45cdce7499e52ba6c36ea3

	# Python Documentation (3.13.7) - 10,183 KB:
	# Download: https://www.python.org/ftp/python/doc/3.13.7/python-3.13.7-docs-html.tar.bz2
	# MD5 sum: b84c0d81b2758398bb7f5b7411d3d908
	echoR "System Software"

	echoL "Downloading Python (3.13.7)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz Python-3.13.7.tar.xz
	cp ../Packages/Python-3.13.7.tar.xz /sources

	../bash/Download.sh https://www.python.org/ftp/python/doc/3.13.7/python-3.13.7-docs-html.tar.bz2 python-3.13.7-docs-html.tar.bz2
	cp ../Packages/python-3.13.7-docs-html.tar.bz2 /sources

	echoL "Unpack Python (3.13.7)..."
	sleep 2
	cd /sources
	rm -fR Python-3.13.7
	tar -vxsf Python-3.13.7.tar.xz
	cd Python-3.13.7

	echoL "Building Python (3.13.7)..."
	sleep 2
	./configure --prefix=/usr  \
		--enable-shared        \
		--with-system-expat    \
		--enable-optimizations \
		--without-static-libpython
	make

	echoL "Testing Python (3.13.7)..."
	sleep 2
	make test TESTOPTS="--timeout 120"
	echo "One test, test_ssl, is known to fail in the chroot environment."

	echoL "Installing Python (3.13.7)..."
	sleep 2
	make install
	cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF
	# reinstall the same version for some reason, insert --force-reinstall --no-deps into the command line.
	install -v -dm755 /usr/share/doc/python-3.13.7/html
	tar --strip-components=1  \
		--no-same-owner       \
		--no-same-permissions \
		-C /usr/share/doc/python-3.13.7/html \
		-xvf ../python-3.13.7-docs-html.tar.bz2
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR Python-3.13.7

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
