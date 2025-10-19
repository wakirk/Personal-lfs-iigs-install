Kbd (2.8.0) - 1,448 KB:
Home page: https://kbd-project.org/
Download: https://www.kernel.org/pub/linux/utils/kbd/kbd-2.8.0.tar.xz
MD5 sum: 24b5d24f7483726b88f214dc6c77aa41

Kbd Backspace/Delete Fix Patch - 12 KB:
Download: https://www.linuxfromscratch.org/patches/lfs/12.4/kbd-2.8.0-backspace-1.patch
MD5 sum: f75cca16a38da6caa7d52151f7136895



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



8.67.1. Installation of Kbd
The behavior of the backspace and delete keys is not consistent across the keymaps in the Kbd package. The following patch fixes this issue for i386 keymaps:

patch -Np1 -i ../kbd-2.8.0-backspace-1.patch
After patching, the backspace key generates the character with code 127, and the delete key generates a well-known escape sequence.

Remove the redundant resizecons program (it requires the defunct svgalib to provide the video mode files - for normal use setfont sizes the console appropriately) together with its manpage.

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
Prepare Kbd for compilation:

./configure --prefix=/usr --disable-vlock
The meaning of the configure option:

--disable-vlock
This option prevents the vlock utility from being built because it requires the PAM library, which isn't available in the chroot environment.

Compile the package:

make
The tests for this package will all fail in the chroot environment because they require valgrind. In addition on a full system with valgrind, several tests still fail in a graphical environment. The tests pass in a non-graphical environment.

Install the package:

make install
[Note] Note
For some languages (e.g., Belarusian) the Kbd package doesn't provide a useful keymap where the stock “by” keymap assumes the ISO-8859-5 encoding, and the CP1251 keymap is normally used. Users of such languages have to download working keymaps separately.

If desired, install the documentation:

cp -R -v docs/doc -T /usr/share/doc/kbd-2.8.0
8.67.2. Contents of Kbd
