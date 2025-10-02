


#
#!/bin/bash
#source /home/lfs/lfs/lib/menu.lib   # In every script.
Make (4.4.1) - 2,300 KB:
Home page: https://www.gnu.org/software/make/
Download: https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
MD5 sum: c8469a3713cbbe04d955d4ae4be23eeb
#main () {
#	clear
#	echoR "Installing Software"
#	echoL "Downloading ..."
#	echo "Downloading... "
#	../bash/Download.sh https*.xz *.xz
#	cp ../Packages/*.xz $LFS/sources
#	cd $LFS/sources
#	ls
#	echoL "Unpack: ..."
#	sleep 2
#	rm -fR *
#	tar -vxsf *
#	cd *
#	echoL "Building ..."
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
make
#	echoL "Installing ..."
make DESTDIR=$LFS install
#	echoL "Install Complete "
#	sleep 2
#	cd ..
#	rm -fR *
#	exit 1
#}
#lfs_identity
#lfs_tmux_entry main  # must be called after the routine it defines.
#
