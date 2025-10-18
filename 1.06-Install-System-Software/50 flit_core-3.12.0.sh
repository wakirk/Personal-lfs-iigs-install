Flit-core (3.12.0) - 53 KB:
Home page: https://pypi.org/project/flit-core/

Download: https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz

MD5 sum: c538415c1f27bd69cbbbf3cdd5135d39



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









8.52.1. Installation of Flit-Core
Build the package:

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
Install the package:

pip3 install --no-index --find-links dist flit_core
The meaning of the pip3 configuration options and commands:

wheel
This command builds the wheel archive for this package.

-w dist
Instructs pip to put the created wheel into the dist directory.

--no-cache-dir
Prevents pip from copying the created wheel into the /root/.cache/pip directory.

install
This command installs the package.

--no-build-isolation, --no-deps, and --no-index
These options prevent fetching files from the online package repository (PyPI). If packages are installed in the correct order, pip won't need to fetch any files in the first place; these options add some safety in case of user error.

--find-links dist
Instructs pip to search for wheel archives in the dist directory.

8.52.2. Contents of Flit-Core
