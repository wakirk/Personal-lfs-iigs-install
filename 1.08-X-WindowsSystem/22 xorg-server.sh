	22. xorg-server	xorg-server — The X display server (“Xorg”) that draws windows on your GPU/monitor. xorg-server (use the built-in modesetting driver; works with kernel DRM)	Start X without a desktop

https://chatgpt.com/g/g-p-68bf3444284c8191937ab3e8dcd8a503-iigs-linux-from-scratch-build/project
https://www.linuxfromscratch.org/lfs/view/stable/chapter03/packages.html
https://github.com/wakirk/Personal-lfs-iigs-install/tree/434aeed03f038aff88ac33cee6e32a63b904570d

https://www.linuxfromscratch.org/blfs/view/stable/x/xorg-server.html

/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

 main () {

	Utils (5.8.1) - 1,428 KB:
	Home page: https://tukaani.org/xz
	Download: https: .tar.xz
	MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3
	echoR "System Software"

	echoL "Downloading ------- ( ) ..."
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
