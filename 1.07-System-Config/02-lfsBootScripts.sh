#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# LFS-Bootscripts (20250827) - 34 KB:
	# Download: https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz
	# MD5 sum: 3f661c64c2dfb55025767ed56074d059

	echoL "Downloading LFS-Bootscripts (20250827)..."
	echoR "System Software"
	sleep 2
	cd "/root/lfs/1.07-System-Config"
	../bash/Download.sh https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz lfs-bootscripts-20250827.tar.xz
	cp ../Packages/lfs-bootscripts-20250827.tar.xz /sources
	
	echoL "Unpack: LFS-Bootscripts (20250827)..."
	sleep 2
	cd /sources
	rm -fR lfs-bootscripts-20250827
	tar -vxsf lfs-bootscripts-20250827.tar.xz
	cd  lfs-bootscripts-20250827

	echoL "Installing LFS-Bootscripts (20250827)..."
	sleep 2
	make install
	
	# inserting this here because I got no better place to put it.
	# https://www.linuxfromscratch.org/lfs/view/stable/chapter09/usage.html

	cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S06:once:/sbin/sulogin
s1:1:respawn:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR lfs-bootscripts-20250827
	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
