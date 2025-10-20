#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

 main () {

	# Linux (6.16.1) - 149,042 KB:
	# Home page: https://www.kernel.org/
	# Download: https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz
	# MD5 sum: 32d45755e4b39d06e9be58f6817445ee
	echoR "Kernel Software"

	echoL "Downloading Linux (6.16.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz linux-6.16.1.tar.xz
	cp ../Packages/linux-6.16.1.tar.xz /sources

	echoL "Unpack Linux (6.16.1)..."
	sleep 2
	cd /sources
	rm -fR linux-6.16.1
	tar -vxsf linux-6.16.1.tar.xz
	cd linux-6.16.1

	echoL "Building Linux (6.16.1)..."
	sleep 2
	make mrproper
	make defconfig
	make menuconfig
	make

	echoL "Installing Linux (6.16.1)..."
	sleep 2
	make modules_install
	cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.16.1-lfs-12.4
	cp -iv System.map /boot/System.map-6.16.1
	cp -iv .config /boot/config-6.16.1
	cp -r Documentation -T /usr/share/doc/linux-6.16.1
	install -v -m755 -d /etc/modprobe.d
	cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR linux-6.16.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
