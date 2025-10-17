#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

Shadow (4.18.0) - 2,293 KB:
Home page: https://github.com/shadow-maint/shadow/
Download: https://github.com/shadow-maint/shadow/releases/download/4.18.0/shadow-4.18.0.tar.xz
MD5 sum: 30ef46f54363db1d624587be68794ef2
	echoR "System Software"

	echoL "Downloading Shadow (4.18.0)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/shadow-maint/shadow/releases/download/4.18.0/shadow-4.18.0.tar.xz shadow-4.18.0.tar.xz
	cp ../Packages/shadow-4.18.0.tar.xz /sources

	echoL "Unpack Shadow (4.18.0)..."
	sleep 2
	cd /sources
	rm -fR shadow-4.18.0
	tar -vxsf shadow-4.18.0.tar.xz
	cd shadow-4.18.0

	echoL "Building Shadow (4.18.0)..."
	sleep 2
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
    -e 's:/var/spool/mail:/var/mail:'                   \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
    -i etc/login.defs
touch /usr/bin/passwd
./configure --sysconfdir=/etc   \
            --disable-static    \
            --with-{b,yes}crypt \
            --without-libbsd    \
            --with-group-name-max-length=32    
make


	echoL "Installing Shadow (4.18.0)..."
	sleep 2
make exec_prefix=/usr install
make -C man install-man
mkdir -p /etc/default
  # useradd -D --gid 999
  /bin/bash
 # passwd root password
  
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR shadow-4.18.0

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1















