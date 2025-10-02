
Tar (1.35) - 2,263 KB:
Home page: https://www.gnu.org/software/tar/
Download: https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz
MD5 sum: a2d8042658cfd8ea939e6d911eaf4152


#
#!/bin/bash
#source /home/lfs/lfs/lib/menu.lib   # In every script.
###
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
