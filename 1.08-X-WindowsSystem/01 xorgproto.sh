
https://chatgpt.com/g/g-p-68bf3444284c8191937ab3e8dcd8a503-iigs-linux-from-scratch-build/project
https://www.linuxfromscratch.org/lfs/view/stable/chapter03/packages.html
https://github.com/wakirk/Personal-lfs-iigs-install/tree/434aeed03f038aff88ac33cee6e32a63b904570d


/bin/bash



source /root/lfs/lib/menu.lib   # In every script.

 main () {

	# 1. xorgproto	— Header files describing X11/extension protocols; needed to build X libraries.
	# xorgproto (2024.1)
	# https://www.linuxfromscratch.org/blfs/view/stable/x/xorgproto.html
	# https://superuser.com/questions/904142/launching-programs-with-gui-without-display-manager?utm_source=chatgpt.com
	# Download (HTTP): https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz
	# Download MD5 sum: 12374d29fb5ae642cfa872035e401640
	# Download size: 744 KB
	# Estimated disk space required: 8.4 MB
	# Estimated build time: less than 0.1 SBU
	echoR "System Software"

	echoL "Downloading xorgproto (2024.1)..."
	sleep 2
	cd "/root/lfs/1.08-X-WindowsSystem"
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
