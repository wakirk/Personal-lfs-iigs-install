OpenSSL (3.5.2) - 51,934 KB:
Home page: https://www.openssl-library.org/

Download: https://github.com/openssl/openssl/releases/download/openssl-3.5.2/openssl-3.5.2.tar.gz

MD5 sum: 890fc59f86fc21b5e4d1c031a698dbde



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




8.48.1. Installation of OpenSSL
Prepare OpenSSL for compilation:

./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic
Compile the package:

make
To test the results, issue:

HARNESS_JOBS=$(nproc) make test
One test, 30-test_afalg.t, is known to fail if the host kernel does not have CONFIG_CRYPTO_USER_API_SKCIPHER enabled, or does not have any options providing an AES with CBC implementation (for example, the combination of CONFIG_CRYPTO_AES and CONFIG_CRYPTO_CBC, or CONFIG_CRYPTO_AES_NI_INTEL if the CPU supports AES-NI) enabled. If it fails, it can safely be ignored.

Install the package:

sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install
Add the version to the documentation directory name, to be consistent with other packages:

mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.5.2
If desired, install some additional documentation:

cp -vfr doc/* /usr/share/doc/openssl-3.5.2
[Note] Note
You should update OpenSSL when a new version which fixes vulnerabilities is announced. Since OpenSSL 3.0.0, the OpenSSL versioning scheme follows the MAJOR.MINOR.PATCH format. API/ABI compatibility is guaranteed for the same MAJOR version number. Because LFS installs only the shared libraries, there is no need to recompile packages which link to libcrypto.so or libssl.so when upgrading to a version with the same MAJOR version number.

However, any running programs linked to those libraries need to be stopped and restarted. Read the related entries in Section 8.2.1, “Upgrade Issues” for details.

8.48.2. Contents of OpenSSL
