Python (3.13.7) - 22,236 KB:
Home page: https://www.python.org/

Download: https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz

MD5 sum: 256cdb3bbf45cdce7499e52ba6c36ea3






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




8.51.1. Installation of Python 3
Prepare Python for compilation:

./configure --prefix=/usr          \
            --enable-shared        \
            --with-system-expat    \
            --enable-optimizations \
            --without-static-libpython
The meaning of the configure options:

--with-system-expat
This switch enables linking against the system version of Expat.

--enable-optimizations
This switch enables extensive, but time-consuming, optimization steps. The interpreter is built twice; tests performed on the first build are used to improve the optimized final version.

Compile the package:

make
Some tests are known to occasionally hang indefinitely. So to test the results, run the test suite but set a 2-minute time limit for each test case:

make test TESTOPTS="--timeout 120"
For a relatively slow system you may need to increase the time limit and 1 SBU (measured when building Binutils pass 1 with one CPU core) should be enough. Some tests are flaky, so the test suite will automatically re-run failed tests. If a test failed but then passed when re-run, it should be considered as passed. One test, test_ssl, is known to fail in the chroot environment.

Install the package:

make install
We use the pip3 command to install Python 3 programs and modules for all users as root in several places in this book. This conflicts with the Python developers' recommendation: to install packages into a virtual environment, or into the home directory of a regular user (by running pip3 as this user). A multi-line warning is triggered whenever pip3 is issued by the root user.

The main reason for the recommendation is to avoid conflicts with the system's package manager (dpkg, for example). LFS does not have a system-wide package manager, so this is not a problem. Also, pip3 will check for a new version of itself whenever it's run. Since domain name resolution is not yet configured in the LFS chroot environment, pip3 cannot check for a new version of itself, and will produce a warning.

After we boot the LFS system and set up a network connection, a different warning will be issued, telling the user to update pip3 from a pre-built wheel on PyPI (whenever a new version is available). But LFS considers pip3 to be a part of Python 3, so it should not be updated separately. Also, an update from a pre-built wheel would deviate from our objective: to build a Linux system from source code. So the warning about a new version of pip3 should be ignored as well. If you wish, you can suppress all these warnings by running the following command, which creates a configuration file:

cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF
[Important] Important
In LFS and BLFS we normally build and install Python modules with the pip3 command. Please be sure that the pip3 install commands in both books are run as the root user (unless it's for a Python virtual environment). Running pip3 install as a non-root user may seem to work, but it will cause the installed module to be inaccessible by other users.

pip3 install will not reinstall an already installed module automatically. When using the pip3 install command to upgrade a module (for example, from meson-0.61.3 to meson-0.62.0), insert the option --upgrade into the command line. If it's really necessary to downgrade a module, or reinstall the same version for some reason, insert --force-reinstall --no-deps into the command line.

If desired, install the preformatted documentation:

install -v -dm755 /usr/share/doc/python-3.13.7/html

tar --strip-components=1  \
    --no-same-owner       \
    --no-same-permissions \
    -C /usr/share/doc/python-3.13.7/html \
    -xvf ../python-3.13.7-docs-html.tar.bz2
The meaning of the documentation install commands:

--no-same-owner and --no-same-permissions
Ensure the installed files have the correct ownership and permissions. Without these options, tar will install the package files with the upstream creator's values.

8.51.2. Contents of Python 3



