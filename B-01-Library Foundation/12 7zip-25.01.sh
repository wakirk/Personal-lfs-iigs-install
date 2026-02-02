#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

# 7zip Dependencies
#	Optional
#	UASM

main () {

	# Download (HTTP): https://github.com/ip7z/7zip/archive/25.01/7zip-25.01.tar.gz
	# Download MD5 sum: 0f820e4e77bd0fe6a1145e01a23fd886
	# Download size: 2.1 MB
	# Estimated disk space required: 38 MB
	# Estimated build time: 1.4 SBU
	echoR "Group 1 Library Foundation"

	echoL "Downloading 7zip (25.01)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://github.com/ip7z/7zip/archive/25.01/7zip-25.01.tar.gz 7zip-25.01.tar.gz
	cp ../Packages/7zip-25.01.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack 7zip (25.01)..."
	sleep 2
	cd /sources
	rm -fR 7zip-25.01
	tar -vxsf 7zip-25.01.tar.gz
	cd 7zip-25.01

	echoL "Building 7zip (25.01)..."
	sleep 2
	(for i in Bundles/{Alone,Alone7z,Format7zF,SFXCon} UI/Console; do
		make -C CPP/7zip/$i -f ../../cmpl_gcc.mak || exit
	done)

	echoL "Installing 7zip (25.01)..."
	sleep 2
	install -vDm755 CPP/7zip/Bundles/Alone{/b/g/7za,7z/b/g/7zr} \
			CPP/7zip/Bundles/Format7zF/b/g/7z.so        \
			CPP/7zip/UI/Console/b/g/7z                  \
			-t /usr/lib/7zip/                           &&
	install -vm755 CPP/7zip/Bundles/SFXCon/b/g/7zCon \
			/usr/lib/7zip/7zCon.sfx           &&
	(for i in 7z 7za 7zr; do
		cat > /usr/bin/$i << EOF || exit
#!/bin/sh
exec /usr/lib/7zip/$i "\$@"
EOF
	chmod 755 /usr/bin/$i || exit
	done) &&
	cp -rv DOC -T /usr/share/doc/7zip-25.01

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR 7zip-25.01

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
