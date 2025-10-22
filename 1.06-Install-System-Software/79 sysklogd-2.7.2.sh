#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Sysklogd (2.7.2) - 474 KB:
	# Home page: https://www.infodrom.org/projects/sysklogd/
	# Download: https://github.com/troglobit/sysklogd/releases/download/v2.7.2/sysklogd-2.7.2.tar.gz
	# MD5 sum: af60786956a2dc84054fbf46652e515e
	echoR "System Software"

	echoL "Downloading Sysklogd (2.7.2)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/troglobit/sysklogd/releases/download/v2.7.2/sysklogd-2.7.2.tar.gz sysklogd-2.7.2.tar.gz
	cp ../Packages/sysklogd-2.7.2.tar.gz /sources

	echoL "Unpack Sysklogd (2.7.2)..."
	sleep 2
	cd /sources
	rm -fR sysklogd-2.7.2
	tar -vxsf sysklogd-2.7.2.tar.gz
	cd sysklogd-2.7.2

	echoL "Building Sysklogd (2.7.2)..."
	sleep 2
	./configure --prefix=/usr \
		--sysconfdir=/etc     \
		--runstatedir=/run    \
		--without-logger      \
		--disable-static      \
		--docdir=/usr/share/doc/sysklogd-2.7.2
	make

	echoL "Installing Sysklogd (2.7.2)..."
	sleep 2
	make install
	cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# Do not open any internet ports.
secure_mode 2

# End /etc/syslog.conf
EOF

	
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR sysklogd-2.7.2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
