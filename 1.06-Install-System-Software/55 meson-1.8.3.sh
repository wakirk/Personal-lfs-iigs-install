Meson (1.8.3) - 2,282:
Home page: https://mesonbuild.com
Download: https://github.com/mesonbuild/meson/releases/download/1.8.3/meson-1.8.3.tar.gz
MD5 sum: 08221d2f515e759686f666ff6409a903



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










8.57.1. Installation of Meson
Compile Meson with the following command:

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
The test suite requires some packages outside the scope of LFS.

Install the package:

pip3 install --no-index --find-links dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson
The meaning of the install parameters:

-w dist
Puts the created wheels into the dist directory.

--find-links dist
Installs wheels from the dist directory.

8.57.2. Contents of Meson
