#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	#make-ca Dependencies
	#	Required
	#	p11-kit-0.25.5 (runtime, built after libtasn1-4.20.0, required in the following instructions to generate certificate
	#					stores from trust anchors, and each time make-ca is run)

	#	Optional (runtime)
	#	nss-3.115 (to generate a shared NSSDB)

main () {

	# Download (HTTP): https://github.com/lfs-book/make-ca/archive/v1.16.1/make-ca-1.16.1.tar.gz
	# Download size: 40 KB
	# Download MD5 Sum: bf9cea2d24fc5344d4951b49f275c595
	# Estimated disk space required: 164 KB (with all runtime deps)
	# Estimated build time: less than 0.1 SBU (with all runtime deps)
	echoR "Group 2 Support Library"

	echoL "Downloading make-ca (1.16.1)..."
	sleep 2
	cd "/root/lfs/B-02-Support Library"

	../bash/Download.sh https://github.com/lfs-book/make-ca/archive/v1.16.1/make-ca-1.16.1.tar.gz make-ca-1.16.1.tar.gz
	cp ../Packages/make-ca-1.16.1.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack make-ca (1.16.1)..."
	sleep 2
	cd /sources
	rm -fR make-ca-1.16.1
	tar -vxsf make-ca-1.16.1.tar.gz
	cd make-ca-1.16.1

	echoL "Building make-ca (1.16.1)..."
	sleep 2
	make install

	echoL "Installing make-ca (1.16.1)..."
	sleep 2
	install -vdm755 /etc/ssl/local

	echoL "Configuring make-ca (1.16.1)..."
	sleep 2
	/usr/sbin/make-ca -g
	wget http://www.cacert.org/certs/root.crt
	wget http://www.cacert.org/certs/class3.crt
	openssl x509 -in root.crt -text -fingerprint -setalias "CAcert Class 1 root" \
		-addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
		> /etc/ssl/local/CAcert_Class_1_root.pem &&
	openssl x509 -in class3.crt -text -fingerprint -setalias "CAcert Class 3 root" \
		-addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
		> /etc/ssl/local/CAcert_Class_3_root.pem &&
	/usr/sbin/make-ca -r
	export _PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt
	mkdir -pv /etc/profile.d &&
	cat > /etc/profile.d/pythoncerts.sh << "EOF"
# Begin /etc/profile.d/pythoncerts.sh

export _PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt

# End /etc/profile.d/pythoncerts.sh
EOF

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR make-ca-1.16.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
