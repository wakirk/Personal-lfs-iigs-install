#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# Iana-Etc (20250807) - 592 KB:
	# Home page: https://www.iana.org/protocols
	# Download: https://github.com/Mic92/iana-etc/releases/download/20250807/iana-etc-20250807.tar.gz
	# MD5 sum: de0a909103d4ff59d1424c5ec7ac9e4a

	echoL "Downloading Iana-Etc (20250807)..."
	echoR "System Software"
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/Mic92/iana-etc/releases/download/20250807/iana-etc-20250807.tar.gz iana-etc-20250807.tar.gz
	cp ../Packages/iana-etc-20250807.tar.gz /sources
	
	echoL "Unpack: Iana-Etc (20250807)..."
	sleep 2
	cd /sources
	rm -fR iana-etc-20250807
	tar -vxsf iana-etc-20250807.tar.gz
	cd  iana-etc-20250807

	echoL "Installing Iana-Etc (20250807)..."
	sleep 2
	cp -v services protocols /etc

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR iana-etc-20250807

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
