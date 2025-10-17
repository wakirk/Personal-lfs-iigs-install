#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# GCC (15.2.0) - 98,688 KB:
  # Home page: https://gcc.gnu.org/
  # Download: https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz
  # MD5 sum: b861b092bf1af683c46a8aa2e689a6fd
  echoR "System Software"

	echoL "Downloading GCC (15.2.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz gcc-15.2.0.tar.xz
	cp ../Packages/gcc-15.2.0.tar.xz /sources

	echoL "Unpack GCC (15.2.0)..."
	sleep 2
	cd /sources
	rm -fR gcc-15.2.0
	tar -vxsf gcc-15.2.0.tar.xz
	cd gcc-15.2.0

	echoL "Building GCC (15.2.0)..."
	sleep 2
  case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
  esac
  mkdir -v build
  cd       build
  ../configure --prefix=/usr            \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --enable-host-pie        \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-fixincludes    \
             --with-system-zlib
  ulimit -s -H unlimited
  make
  
  
	echoL "Testing GCC (15.2.0)..."
  sed -e '/cpython/d' -i ../gcc/testsuite/gcc.dg/plugin/plugin.exp
  chown -R tester .
  su tester -c "PATH=$PATH make -k check"
  ../contrib/test_summary

  /bin/bash
  exit 1
	echoL "Installing GCC (15.2.0)..."
	sleep 2
  make install
  chown -v -R root:root /usr/lib/gcc/$(gcc -dumpmachine)/15.2.0/include{,-fixed}
  ln -fsvr /usr/bin/cpp /usr/lib
  ln -fsv gcc.1 /usr/share/man/man1/cc.1
  ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/15.2.0/liblto_plugin.so /usr/lib/bfd-plugins/

	echoL "Checking GCC (15.2.0)..."
	sleep 2
  echo 'int main(){}' | cc -x c - -v -Wl,--verbose &> dummy.log
  readelf -l a.out | grep ': /lib'
  echo "[Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]"
  read
  grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log
  echo "/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/../../../../lib/Scrt1.o succeeded"
  echo "/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/../../../../lib/crti.o succeeded"
  echo "/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/../../../../lib/crtn.o succeeded"
  read
  grep -B4 '^ /usr/include' dummy.log
  echo "#include <...> search starts here:"
  echo "/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/include"
  echo "/usr/local/include"
  echo "/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/include-fixed"
  echo "/usr/include"
  read 
  grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
  echo "SEARCH_DIR(\"/usr/x86_64-pc-linux-gnu/lib64\")"
  echo "SEARCH_DIR(\"/usr/local/lib64\")"
  echo "SEARCH_DIR(\"/lib64\")"
  echo "SEARCH_DIR(\"/usr/lib64\")"
  echo "SEARCH_DIR(\"/usr/x86_64-pc-linux-gnu/lib\")"
  echo "SEARCH_DIR(\"/usr/local/lib\")"
  echo "SEARCH_DIR(\"/lib\")"
  echo "SEARCH_DIR(\"/usr/lib\")";
  read
  grep "/lib.*/libc.so.6 " dummy.log
  echo "attempt to open /usr/lib/libc.so.6 succeeded"
  read 
  grep found dummy.log
  echo "found ld-linux-x86-64.so.2 at /usr/lib/ld-linux-x86-64.so.2"
  read
  mkdir -pv /usr/share/gdb/auto-load/usr/lib
  mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
  /bin/bash
  
  echoL "Cleaning up build area...."
	sleep 2
	cd /sources
  rm -v a.out dummy.log
	rm -fR gcc-15.2.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
