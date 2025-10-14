#!/bin/bash

source /root/lfs/USB/userID.key  # Access Keys
source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.04-XCompilingTempTools

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Entering Chroot and Building Additional Temporary Tools"
	echo " "
}

sysconfig() {
	# 00 SysConfig Setup.sh	Ch Root Configuration Setup
	echoL "Installing Chroot Required Software"
	echoR "Installing Setup Support"
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Gettext() {
	# 01 Gettext-0.26.sh	Gettext 0.26	echoL "Installing Chroot Required Software"
	# Gettext (0.26) - 9,926 KB:
	# Home page: https://www.gnu.org/software/gettext/
	# Download: https://ftp.gnu.org/gnu/gettext/gettext-0.26.tar.xz
	# MD5 sum: 8e14e926f088e292f5f2bce95b81d10e

	echoL "Downloading Gettext (0.26)..."
	echoR "Installing Setup Support"
	../bash/Download.sh  https://ftp.gnu.org/gnu/gettext/gettext-0.26.tar.xz gettext-0.26.tar.xz
	cp ../Packages/gettext-0.26.tar.xz $LFS/sources

	echoL "Installing Gettext (0.26)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Bison() {
	# 02 Bison-3.8.2.sh	Bison 3.8.2
	# Bison (3.8.2) - 2,752 KB:
	# Home page: https://www.gnu.org/software/bison/
	# Download: https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz
	# MD5 sum: c28f119f405a2304ff0a7ccdcc629713

	echoL "Downloading Bison (3.8.2)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz bison-3.8.2.tar.xz
	cp ../Packages/bison-3.8.2.tar.xz $LFS/sources

	echoL "Installing Bison (3.8.2)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Perl() {
	# 03 Perl-5.42.0.sh	Perl 5.42
	# Perl (5.42.0) - 14,084 KB:
	# Home page: https://www.perl.org/
	# Download: https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
	# MD5 sum: 7a6950a9f12d01eb96a9d2ed2f4e0072

	echoL "Downloading Perl (5.42)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz perl-5.42.0.tar.xz
	cp ../Packages/perl-5.42.0.tar.xz $LFS/sources

	echoL "Installing Perl (5.42)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Python() {
	# 04 Python-3.13.7.sh	Python 3.13.7
	# Python (3.13.7) - 22,236 KB:
	# Home page: https://www.python.org/
	# Download: https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz
	# MD5 sum: 256cdb3bbf45cdce7499e52ba6c36ea3

	echoL "Downloading Python (3.13.7)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz Python-3.13.7.tar.xz
	cp ../Packages/Python-3.13.7.tar.xz $LFS/sources

	echoL "Installing Python (3.13.7)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Texinfo() {
	# 05 Texinfo-7.2.sh	Texinfo 7.2
	# Texinfo (7.2) - 6,259 KB:
	# Home page: https://www.gnu.org/software/texinfo/
	# Download: https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz
	# MD5 sum: 11939a7624572814912a18e76c8d8972

	echoL "Downloading Texinfo (7.2)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz texinfo-7.2.tar.xz
	cp ../Packages/texinfo-7.2.tar.xz $LFS/sources

	echoL "Installing Texinfo (7.2)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Utillinux() {
	# 06 Util-linux-2.41.1.sh Util-linux 2.41
	# Util-linux (2.41.1) - 9,382 KB:
	# Home page: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/
	# Download: https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz
	# MD5 sum: 7e5e68845e2f347cf96f5448165f1764

	echoL "Downloading Util-linux (2.41.1)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz util-linux-2.41.1.tar.xz
	cp ../Packages/util-linux-2.41.1.tar.xz $LFS/sources

	echoL "Installing Util-linux (2.41.1)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

OpenSSL() {
	# 07 OpenSSL 3.6.0.sh	OpenSSL 3.6.0

	echoL "Downloading OpenSSL (3.6.0)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://github.com/openssl/openssl/releases/download/openssl-3.6.0/openssl-3.6.0.tar.gz openssl-3.6.0.tar.gz
	cp ../Packages/openssl-3.6.0.tar.gz $LFS/sources

	echoL "Installing OpenSSL (3.6.0)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Pkgconf() {
	# 08 Pkgconf 2.5.1.sh	Pkgconf 2.5.1
	echoL "Downloading Pkgconf (2.5.1)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz pkgconf-2.5.1.tar.xz
	cp ../Packages/pkgconf-2.5.1.tar.xz $LFS/sources

	echoL "Installing Pkgconf (2.5.1)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

libtool() {
	# Libtool-2.5.4	https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libtool.html
	# Libtool (2.5.4) - 1,033 KB:
	# Home page: https://www.gnu.org/software/libtool/
	# Download: https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz
	# MD5 sum: 22e0a29df8af5fdde276ea3a7d351d30
	
	echoL "Downloading Libtool (2.5.4)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz libtool-2.5.4.tar.xz
	cp ../Packages/libtool-2.5.4.tar.xz $LFS/sources

	echoL "Installing Libtool (2.5.4)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

autoconfig() {
	# Autoconf-2.72	https://www.linuxfromscratch.org/lfs/view/stable/chapter08/autoconf.html
	# Autoconf (2.72) - 1,360 KB:
	# Home page: https://www.gnu.org/software/autoconf/
	# Download: https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz
	# MD5 sum: 1be79f7106ab6767f18391c5e22be701
	echoL "Downloading Autoconf (2.72)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz autoconf-2.72.tar.xz
	cp ../Packages/autoconf-2.72.tar.xz $LFS/sources

	echoL "Installing Autoconf (2.72)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

automak() {
	# Automake-1.18.1	https://www.linuxfromscratch.org/lfs/view/stable/chapter08/automake.html
	# Automake (1.18.1) - 1,614 KB:
	# Home page: https://www.gnu.org/software/automake/
	# Download: https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz
	# MD5 sum: cea31dbf1120f890cbf2a3032cfb9a68
	echoL "Downloading Automake (1.18.1)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz automake-1.18.1.tar.xz
	cp ../Packages/automake-1.18.1.tar.xz $LFS/sources

	echoL "Installing Automake (1.18.1)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Libevent() {
	# 09 Libevent 2.1.12.sh	Libevent 2.1.12
	echoL "Downloading libevent (2.1.12)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://github.com/libevent/libevent/archive/refs/tags/release-2.1.12-stable.tar.gz libevent-2.1.12.tar.gz
	cp ../Packages/libevent-2.1.12.tar.gz $LFS/sources

	echoL "Installing libevent (2.1.12)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

Wget() {
	# 10 Wget 1.25.0.sh	Wget 1.25
	# Wget-1.25.0
	# Download (HTTP): https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz
	# Download MD5 sum: c70ba58b36f944e8ba1d655ace552881
	# Download size: 5.0 MB
	echoL "Downloading Wget (1.25.0)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz wget-1.25.0.tar.gz
	cp ../Packages/wget-1.25.0.tar.gz $LFS/sources
	
	echoL "Installing Wget (1.25.0)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

maketmux() {
	# Tmux 3.5a
	# Download (HTTP): https://github.com/tmux/tmux/archive/refs/tags/3.5a.tar.gz tmux-3.5a.tar.gz
	# Download MD5 sum: c70ba58b36f944e8ba1d655ace552881
	# Download size: 5.0 MB
	echoL "Downloading tmux (3.5a)..."
	echoR "Installing Setup Support"
	../bash/Download.sh https://github.com/tmux/tmux/archive/refs/tags/3.5a.tar.gz tmux-3.5a.tar.gz
	cp ../Packages/tmux-3.5a.tar.gz $LFS/sources
	
	echoL "Installing tmux (3.5a)..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

postsetup() {
	# Tmux 3.5a
	# Download (HTTP): https://github.com/tmux/tmux/archive/refs/tags/3.5a.tar.gz tmux-3.5a.tar.gz
	# Download MD5 sum: c70ba58b36f944e8ba1d655ace552881
	# Download size: 5.0 MB
	echoL "Cleaning up Workspace..."
	chroot_entry
	chroot_run "$HERE/$EXEC_SCRIPT"
	chroot_exit
	return_wait 1
	return 1
}

main() {
	menu_setup $HERE/Chroot-Addon-TempTools.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Main Menu"
	echoR "Temporary Build Software"
	return 1
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
