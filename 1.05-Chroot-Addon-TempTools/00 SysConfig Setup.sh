#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	echo "Configuraing System..."

	export PS1='(lfs chroot) \u:\w\$ '
	mkdir -pv /{boot,home,mnt,opt,srv}
	mkdir -pv /etc/{opt,sysconfig}
	mkdir -pv /lib/firmware
	mkdir -pv /media/{floppy,cdrom}
	mkdir -pv /usr/{,local/}{include,src}
	mkdir -pv /usr/lib/locale
	mkdir -pv /usr/local/{bin,lib,sbin}
	mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
	mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
	mkdir -pv /usr/{,local/}share/man/man{1..8}
	mkdir -pv /var/{cache,local,log,mail,opt,spool}
	mkdir -pv /var/lib/{color,misc,locate}

	ln -sfv /run /var/run
	ln -sfv /run/lock /var/lock

	install -dv -m 0750 /root
	install -dv -m 1777 /tmp /var/tmp
	
	ln -sv /proc/self/mounts /etc/mtab

cat > /etc/hosts << EOF
127.0.0.1  localhost $(hostname)
::1        localhost
EOF

cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
tester:x:101:101::/home/tester:/bin/bash
EOF

cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
tester:x:101:
EOF

	cp -vL /etc/resolv.conf "$LFS/etc/resolv.conf"

	install -o tester -d /home/tester

	touch /var/log/{btmp,lastlog,faillog,wtmp}
	chgrp -v utmp /var/log/lastlog
	chmod -v 664  /var/log/lastlog
	chmod -v 600  /var/log/btmp

	/bin/bash

	echo "Exiting..."
	exit 1
}

#lfs_identity
#lfs_tmux_entry main  # must be called after the routine it defines.

main

exit 0


	echoR "Checking Build Environment"

	echoL "Downloading wget 1.25..."
	echo "Downloading wget 1.25..."
	../bash/Download.sh https://gnu.mirror.constant.com/wget/wget-1.25.0.tar.gz wget-1.25.0.tar.gz
	cp ../Packages/wget-1.25.0.tar.gz $LFS/sources

	echoL "Downloading Pkgconf 2.5.1..."
	echo "Downloading Pkgconf 2.5.1..."
	../bash/Download.sh https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz pkgconf-2.5.1.tar.xz
	cp ../Packages/pkgconf-2.5.1.tar.xz $LFS/sources

	echoL "Downloading OpenSSL 3.6.0..."
	echo "Downloading OpenSSL 3.6.0..."
	../bash/Download.sh https://github.com/openssl/openssl/releases/download/openssl-3.6.0/openssl-3.6.0.tar.gz openssl-3.6.0.tar.gz
	cp ../Packages/openssl-3.6.0.tar.gz $LFS/sources

	echoL "Downloading libevent 2.1.12..."
	echo "Downloading libevent 2.1.12..."
	../bash/Download.sh https://github.com/libevent/libevent/archive/refs/tags/release-2.1.12-stable.tar.gz libevent-2.1.12.tar.gz
	cp ../Packages/libevent-2.1.12.tar.gz $LFS/sources
	
	echoR "Configuring LFS System"
	echoL "Building Support System"


	cd /sources
	rm -fR openssl-3.6.0
	tar -vxsf openssl-3.6.0.tar.gz
	cd openssl-3.6.0

	/bin/bash



#	cd /sources
#	rm -fR pkgconf-2.5.1
#	tar -vxsf pkgconf-2.5.1.tar.xz
#	cd pkgconf-2.5.1

#	./configure --prefix=/usr    \
#				--disable-static \
#				--docdir=/usr/share/doc/pkgconf-2.5.1
#	make
#	make install
#	ln -sv pkgconf   /usr/bin/pkg-config
#	ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1

#	cd /sources 
#	rm -fR wget-1.25.0
#	tar -vxsf wget-1.25.0.tar.gz
#	cd wget-1.25.0
#	./configure --prefix=/usr --sysconfdir=/etc --with-ssl=openssl
#	make
#	make install
#	read
	
	
	
#	cd /sources 
#	rm -fR libevent-release-2.1.12-stable
#	tar -vxsf libevent-2.1.12.tar.gz
#	cd libevent-release-2.1.12-stable
#	./configure --prefix=/usr --sysconfdir=/etc --disable-shared --disable-thread-support
#	/bin/bash

#	cd /sources
#	tar -vxsf wget-1.25.0.tar.gz
#	chroot_shell

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
#	echoL "Installing ..."
#	echoL "Install Complete "
#	sleep 2
#	cd ..
#	rm -fR *
#	exit 1
#}
#lfs_identity
#lfs_tmux_entry main  # must be called after the routine it defines.
#