#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# E2fsprogs (1.47.3) - 9,851 KB:
	# Home page: https://e2fsprogs.sourceforge.net/
	# Download: https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz
	# MD5 sum: 113d7a7ee0710d2a670a44692a35fd2e
	echoR "System Software"

	echoL "Downloading E2fsprogs (1.47.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz e2fsprogs-1.47.3.tar.gz
	cp ../Packages/e2fsprogs-1.47.3.tar.gz /sources

	echoL "Unpack E2fsprogs (1.47.3)..."
	sleep 2
	cd /sources
	rm -fR e2fsprogs-1.47.3
	tar -vxsf e2fsprogs-1.47.3.tar.gz
	cd e2fsprogs-1.47.3

	echoL "Building E2fsprogs (1.47.3)..."
	sleep 2
	mkdir -v build
	cd       build
	../configure --prefix=/usr \
		--sysconfdir=/etc      \
		--enable-elf-shlibs    \
		--disable-libblkid     \
		--disable-libuuid      \
		--disable-uuidd        \
		--disable-fsck
	make

	echoL "Testing E2fsprogs (1.47.3)..."
	sleep 2
	make check
	echo "One test named m_assume_storage_prezeroed is known to fail."


	echoL "Installing E2fsprogs (1.47.3)..."
	sleep 2
	make install
	rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
	gunzip -v /usr/share/info/libext2fs.info.gz
	install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
	makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
	install -v -m644 doc/com_err.info /usr/share/info
	install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
	sed 's/metadata_csum_seed,//' -i /etc/mke2fs.conf
	echo "/etc/mke2fs.conf contains the default value of various command line options of mke2fs."
	echo "You may edit the file to make the default values suitable for your needs. For example,"
	echo "some utilities (not in LFS or BLFS) cannot recognize a ext4 file system with metadata_csum_seed"
	echo "feature enabled. If you need such a utility, you may remove the feature from the default"
	echo "ext4 feature list with the command:"

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR e2fsprogs-1.47.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
