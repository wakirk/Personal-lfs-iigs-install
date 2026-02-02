#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Download (HTTP): https://github.com/linux-pam/linux-pam/releases/download/v1.7.1/Linux-PAM-1.7.1.tar.xz
	# Download MD5 sum: 92812d7dd414d816fba8d649e84e68ca
	# Download size: 500 KB
	# Estimated disk space required: 16 MB (with tests)
	# Estimated build time: 0.3 SBU (with tests)	echoR "Group 4 Security Layer"

	# Download (HTTP): https://anduin.linuxfromscratch.org/BLFS/Linux-PAM/Linux-PAM-1.7.1-docs.tar.xz
	# Download MD5 sum: f147017efb39a670bad3e8b614df50f0
	# Download size: 499 KB
	echoL "Downloading Linux-PAM (1.7.1)..."
	sleep 2
	cd "/root/lfs/B-04-Security Layer"
	../bash/Download.sh https://github.com/linux-pam/linux-pam/releases/download/v1.7.1/Linux-PAM-1.7.1.tar.xz Linux-PAM-1.7.1.tar.xz
	cp ../Packages/Linux-PAM-1.7.1.tar.xz /sources

	../bash/Download.sh https://anduin.linuxfromscratch.org/BLFS/Linux-PAM/Linux-PAM-1.7.1-docs.tar.xz Linux-PAM-1.7.1-docs.tar.xz
	cp ../Packages/Linux-PAM-1.7.1-docs.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Linux-PAM (1.7.1)..."
	sleep 2
	cd /sources
	rm -fR Linux-PAM-1.7.1
	tar -vxsf Linux-PAM-1.7.1.tar.xz
	cd Linux-PAM-1.7.1

	echoL "Building Linux-PAM (1.7.1)..."
	sleep 2
	mkdir build
	cd    build
	meson setup ..      \
	--prefix=/usr       \
	--buildtype=release \
	-D docdir=/usr/share/doc/Linux-PAM-1.7.1
	ninja

	echoL "Testing Linux-PAM (1.7.1)..."
	sleep 2
	install -v -m755 -d /etc/pam.d
cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF
	ninja test

	rm -fv /etc/pam.d/other

	echoL "Installing Linux-PAM (1.7.1)..."
	sleep 2
	ninja install
	chmod -v 4755 /usr/sbin/unix_chkpwd
	rm -rf /usr/lib/systemd
	tar -C / -xvf ../../Linux-PAM-1.7.1-docs.tar.xz

cat > /etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth        required        pam_warn.so
auth        required        pam_deny.so
account     required        pam_warn.so
account     required        pam_deny.so
password    required        pam_warn.so
password    required        pam_deny.so
session     required        pam_warn.so
session     required        pam_deny.so

# End /etc/pam.d/other
EOF

install -vdm755 /etc/pam.d &&

cat > /etc/pam.d/system-account << "EOF"
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

cat > /etc/pam.d/system-auth << "EOF"
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

cat > /etc/pam.d/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF

	cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use yescrypt hash for encryption, use shadow, and try to use any
# previously defined authentication token (chosen password) set by any
# prior module.
password  required    pam_unix.so       yescrypt shadow try_first_pass

# End /etc/pam.d/system-password
EOF

	cat > /etc/pam.d/sshd << "EOF"
# /etc/pam.d/sshd  (BLFS split stack)
auth       required     pam_env.so
auth       substack     system-auth
account    required     pam_nologin.so
account    include      system-account
password   include      system-password
session    required     pam_limits.so
session    include      system-session
session    optional     pam_loginuid.so
EOF

cat > /etc/ssh/sshd_config << "EOF"
UsePAM yes
PasswordAuthentication yes
# KbdInteractiveAuthentication yes # (optional; some PAM stacks use this path)
EOF


	echo " "
	echo "The PAM man page (man pam) provides a good starting point to learn about the several"
	echo "fields, and allowable entries. The Linux-PAM System Administrators' Guide"
	echo "at /usr/share/doc/Linux-PAM-1.7.0/Linux-PAM_SAG.txt is recommended for additional"
	echo "information."
	sleep 10

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR Linux-PAM-1.7.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
