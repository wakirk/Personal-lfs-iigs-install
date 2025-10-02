Binutils (2.45) - 27,216 KB:
Home page: https://www.gnu.org/software/binutils/
Download: https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz
MD5 sum: dee5b4267e0305a99a3c9d6131f45759

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

sed '6031s/$add_dir//' -i ltmain.sh

mkdir -v build
cd       build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --enable-gprofng=no        \
    --disable-werror           \
    --enable-64-bit-bfd        \
    --enable-new-dtags         \
    --enable-default-hash-style=gnu
make

#	echoL "Installing ..."

make DESTDIR=$LFS install
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}


#	echoL "Install Complete "
#	sleep 2
#	cd ..
#	rm -fR *
#	exit 1
#}
#lfs_identity
#lfs_tmux_entry main  # must be called after the routine it defines.
#
