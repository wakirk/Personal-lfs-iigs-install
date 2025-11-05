#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Optional
	#	GDB-16.3 (for tests)
	#	Linux-PAM-1.7.1 (PAM configuration files from Shadow-4.18.0 are used to create openssh ones)
	#	Xorg Applications (or Xorg build environment, see Command Explanations)
	#	MIT Kerberos V5-1.22.1
	#	Which-2.23 (for tests)
	#	libedit
	#	LibreSSL Portable
	#	OpenSC
	#	Libsectok

	# Optional Runtime (Used only to gather entropy)
	#	Net-tools-2.10
	#	Sysstat-12.7.8

main () {

	# Download (HTTP): https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.0p1.tar.gz
	# Download MD5 sum: 689148621a2eaa734497b12bed1c5202
	# Download size: 1.9 MB
	# Estimated disk space required: 50 MB (add 22 MB for tests)
	# Estimated build time: 0.4 SBU (Using parallelism=4; running the tests takes about 15 minutes, irrespective of processor speed)
	echoR "Group 4 Security Layer"

	echoL "Downloading OpenSSH (10.0p1)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.0p1.tar.gz openssh-10.0p1.tar.gz
	cp ../Packages/openssh-10.0p1.tar.gz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-20250225.tar.xz blfs-bootscripts-20250225.tar.xz
	cp ../Packages/blfs-bootscripts-20250225.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack OpenSSH (10.0p1)..."
	sleep 2
	cd /sources
	rm -fR blfs-bootscripts-20250225
	tar -vxsf blfs-bootscripts-20250225.tar.xz
	rm -fR openssh-10.0p1
	tar -vxsf openssh-10.0p1.tar.gz
	cd openssh-10.0p1

	echoL "Building OpenSSH (10.0p1)..."
	sleep 2
	install -v -g sys -m700 -d /var/lib/sshd &&
	groupadd -g 50 sshd    &&
	useradd  -c 'sshd PrivSep' \
			 -d /var/lib/sshd  \
			 -g sshd           \
			 -s /bin/false     \
			 -u 50 sshd
	./configure --prefix=/usr                        \
			--sysconfdir=/etc/ssh                    \
			--with-pam                               \
			--with-privsep-path=/var/lib/sshd        \
			--with-default-path=/usr/bin             \
			--with-xauth=$XORG_PREFIX/bin/xauth      \
			--with-libedit                           \
			--with-superuser-path=/usr/sbin:/usr/bin \
			--with-pid-dir=/run
	make

	echoL "Testing OpenSSH (10.0p1)..."
	sleep 2
	make -j1 tests

	echoL "Installing OpenSSH (10.0p1)..."
	sleep 2
	make install &&
	install -v -m755    contrib/ssh-copy-id /usr/bin     &&
	install -v -m644    contrib/ssh-copy-id.1 \
						/usr/share/man/man1              &&
	install -v -m755 -d /usr/share/doc/openssh-10.0p1    &&
	install -v -m644    INSTALL LICENCE OVERVIEW README* \
						/usr/share/doc/openssh-10.0p1
	# If you want to use PAM, issue the following commands as the root user:
	sed 's@d/login@d/sshd@g' /etc/pam.d/login > /etc/pam.d/sshd &&
	chmod 644 /etc/pam.d/sshd &&
	echo "UsePAM yes" >> /etc/ssh/sshd_config
	# Additional configuration information can be found in the man pages for sshd, ssh and ssh-agent.
	# Boot Script
	# To start the SSH server at system boot, install the /etc/rc.d/init.d/sshd init script
	# included in the blfs-bootscripts-20250225 package.
	cd /sources/blfs-bootscripts-20250225
	make install-sshd

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR openssh-10.0p1
	rm -fR blfs-bootscripts-20250225

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
