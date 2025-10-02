#!/bin/bash

source /home/lfs/lfs/lib/menu.lib   # In every script.

#Gawk (5.3.2) - 3,662 KB:
#Home page: https://www.gnu.org/software/gawk/
#Download: https://ftp.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz
#MD5 sum: b7014650c5f45e5d4837c31209dc0037

main () {
	clear	
  echoR "Installing Software"
	echoL "Downloading Gawk (5.3.2)..."

  echo "Downloading Gawk (5.3.2)... "
  ../bash/Download.sh https://ftp.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz gawk-5.3.2.tar.xz
  cp ../Packages/gawk-5.3.2.tar.xz $LFS/sources
  cd $LFS/sources
  ls
  
	echoL "Unpack: Gawk (5.3.2)..."
  sleep 2
  rm -fR gawk-5.3.2
  tar -vxsf gawk-5.3.2.tar.xz
  cd gawk-5.3.2

  echoL "Building Gawk (5.3.2)..."
  sed -i 's/extras//' Makefile.in
  ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
  make
  
	echoL "Installing Gawk (5.3.2)..."
  make DESTDIR=$LFS install
  
  echoL "Install Complete Gawk (5.3.2)"
  sleep 2
  cd ..
  rm -fR gawk-5.3.2

  exit 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
