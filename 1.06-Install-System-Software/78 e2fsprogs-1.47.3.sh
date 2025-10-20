E2fsprogs (1.47.3) - 9,851 KB:
Home page: https://e2fsprogs.sourceforge.net/
Download: https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz
MD5 sum: 113d7a7ee0710d2a670a44692a35fd2e


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




8.80.1. Installation of E2fsprogs
The E2fsprogs documentation recommends that the package be built in a subdirectory of the source tree:

mkdir -v build
cd       build
Prepare E2fsprogs for compilation:

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-elf-shlibs \
             --disable-libblkid  \
             --disable-libuuid   \
             --disable-uuidd     \
             --disable-fsck
The meaning of the configure options:

--enable-elf-shlibs
This creates the shared libraries which some programs in this package use.

--disable-*
These prevent building and installing the libuuid and libblkid libraries, the uuidd daemon, and the fsck wrapper; util-linux installs more recent versions.

Compile the package:

make
To run the tests, issue:

make check
One test named m_assume_storage_prezeroed is known to fail. Another test named m_rootdir_acl is known to fail if the file system used for the LFS system is not ext4.

Install the package:

make install
Remove useless static libraries:

rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
This package installs a gzipped .info file but doesn't update the system-wide dir file. Unzip this file and then update the system dir file using the following commands:

gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
If desired, create and install some additional documentation by issuing the following commands:

makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
8.80.2. Configuring E2fsprogs
/etc/mke2fs.conf contains the default value of various command line options of mke2fs. You may edit the file to make the default values suitable for your needs. For example, some utilities (not in LFS or BLFS) cannot recognize a ext4 file system with metadata_csum_seed feature enabled. If you need such a utility, you may remove the feature from the default ext4 feature list with the command:

sed 's/metadata_csum_seed,//' -i /etc/mke2fs.conf
Read the man page mke2fs.conf(5) for details.

8.80.3. Contents of E2fsprogs













