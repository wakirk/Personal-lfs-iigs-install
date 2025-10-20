Texinfo (7.2) - 6,259 KB:
Home page: https://www.gnu.org/software/texinfo/
Download: https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz
MD5 sum: 11939a7624572814912a18e76c8d8972




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







8.72.1. Installation of Texinfo
Fix a code pattern that causes Perl-5.42 or later to display a warning:

sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm
Prepare Texinfo for compilation:

./configure --prefix=/usr
Compile the package:

make
To test the results, issue:

make check
Install the package:

make install
Optionally, install the components belonging in a TeX installation:

make TEXMF=/usr/share/texmf install-tex
The meaning of the make parameter:

TEXMF=/usr/share/texmf
The TEXMF makefile variable holds the location of the root of the TeX tree if, for example, a TeX package will be installed later.

The Info documentation system uses a plain text file to hold its list of menu entries. The file is located at /usr/share/info/dir. Unfortunately, due to occasional problems in the Makefiles of various packages, it can sometimes get out of sync with the info pages installed on the system. If the /usr/share/info/dir file ever needs to be recreated, the following optional commands will accomplish the task:

pushd /usr/share/info
  rm -v dir
  for f in *
    do install-info $f dir 2>/dev/null
  done
popd
8.72.2. Contents of Texinfo









