#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {
	# GRUB (2.12) - 6,524 KB:
	# Home page: https://www.gnu.org/software/grub/
	# Download: https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz
	# MD5 sum: 60c564b1bdc39d8e43b3aab4bc0fb140

	# GRUB-2.12				https://www.linuxfromscratch.org/lfs/view/stable/chapter08/grub.html
	# Popt-1.19				https://www.linuxfromscratch.org/blfs/view/12.4/general/popt.html
	# efivar-39				https://www.linuxfromscratch.org/blfs/view/12.4/postlfs/efivar.html
	# efibootmgr-18			https://www.linuxfromscratch.org/blfs/view/12.4/postlfs/efibootmgr.html
	# GRUB-2.12 for EFI		https://www.linuxfromscratch.org/blfs/view/12.4/postlfs/grub-efi.html
	# Boot Setup:			https://www.linuxfromscratch.org/blfs/view/12.4/postlfs/grub-setup.html
	echoR "System Software"

	echoL "Downloading GRUB (2.12)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	# Installation of Popt
	# Download (HTTP): https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-1.19.tar.gz
	# Download MD5 sum: eaa2135fddb6eb03f2c87ee1823e5a78
	# Download size: 584 KB
	# Estimated disk space required: 6.9 MB (includes installing documentation and tests)
	# Estimated build time: less than 0.1 SBU (with tests)
	../bash/Download.sh https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-1.19.tar.gz popt-1.19.tar.gz
	cp ../Packages/popt-1.19.tar.gz /sources

	# Installation of efivar
	# Download (HTTP): https://github.com/rhboot/efivar/archive/39/efivar-39.tar.gz
	# Download MD5 sum: a8fc3e79336cd6e738ab44f9bc96a5aa
	# Download size: 456 KB
	# Estimated disk space required: 21 MB
	# Estimated build time: less than 0.1 SBU
	../bash/Download.sh https://github.com/rhboot/efivar/archive/39/efivar-39.tar.gz efivar-39.tar.gz
	cp ../Packages/efivar-39.tar.gz /sources

	# Installation of efibootmgr
	# Download (HTTP): https://github.com/rhboot/efibootmgr/archive/18/efibootmgr-18.tar.gz
	# Download MD5 sum: e170147da25e1d5f72721ffc46fe4e06
	# Download size: 48 KB
	# Estimated disk space required: 1.1 MB
	# Estimated build time: less than 0.1 SBU
	../bash/Download.sh https://github.com/rhboot/efibootmgr/archive/18/efibootmgr-18.tar.gz efibootmgr-18.tar.gz
	cp ../Packages/efibootmgr-18.tar.gz /sources

	# Installation of GRUB
	# Download (HTTP): https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz
	# Download MD5 sum: 60c564b1bdc39d8e43b3aab4bc0fb140
	# Download size: 29 MB
	# Estimated disk space required: 174 MB (with optional dependencies and download)
	# Estimated build time: 0.6 SBU
	../bash/Download.sh https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz grub-2.12.tar.xz
	cp ../Packages/grub-2.12.tar.xz /sources

	echoL "Unpack GRUB (2.12), popt, efivar, efibootmgr..."
	sleep 2
	cd /sources
	rm -fR grub-2.12
	rm -fR popt-1.19
	rm -fR efivar-39
	rm -fR efibootmgr-18
	tar -vxsf grub-2.12.tar.xz
	tar -vxsf popt-1.19.tar.gz
	tar -vxsf efivar-39.tar.gz
	tar -vxsf efibootmgr-18.tar.gz

	# Popt (1.19)
	echoL "Building Popt (1.19)..."
	sleep 2
	cd /sources/popt-1.19
	./configure --prefix=/usr --disable-static
	make

	echoL "Testing Popt (1.19)..."
	sleep 2
	make check

	echoL "Installing Popt (1.19)..."
	sleep 2
	make install

	# efivar (39)
	echoL "Building efivar (39)..."
	sleep 2
	cd /sources/efivar-39
	make ENABLE_DOCS=0

	echoL "Installing efivar (39)..."
	sleep 2
	make install ENABLE_DOCS=0 LIBDIR=/usr/lib
	install -vm644 docs/efivar.1 /usr/share/man/man1 &&
	install -vm644 docs/*.3      /usr/share/man/man3

	# efibootmgr (18)
	echoL "Building efibootmgr (18)..."
	sleep 2
	cd /sources/efibootmgr-18
	make EFIDIR=LFS EFI_LOADER=grubx64.efi

	echoL "Installing efibootmgr (18)..."
	sleep 2
	make install EFIDIR=LFS

	# GRUB (2.12)
	echoL "Building GRUB (2.12)..."
	sleep 2
	cd /sources/grub-2.12
	unset {C,CPP,CXX,LD}FLAGS
	echo depends bli part_gpt > grub-core/extra_deps.lst
	./configure --prefix=/usr \
		--sysconfdir=/etc     \
		--disable-efiemu      \
		--with-platform=efi   \
		--target=x86_64       \
		--disable-werror
	make

	echoL "Installing GRUB (2.12)..."
	sleep 2
	make install
	mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR grub-2.12
	rm -fR popt-1.19
	rm -fR efivar-39
	rm -fR efibootmgr-18

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
