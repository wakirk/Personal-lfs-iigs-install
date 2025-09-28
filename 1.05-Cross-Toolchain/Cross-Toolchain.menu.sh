#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
source /root/lfs/USB/userID.key  # Access Keys
export $SHARE, $SHARE_USER, $SHARE_PASS, $SHARE_VERS, $SHARE_ID
cd /root/lfs/1.02-Preparing

Menu_Pre_Render() {
	clear
	echo " "
	echo " "
	echo "     Build System Software"
	echo " "
}

main() {
	menu_setup $HERE/Cross-Toolchain.menu.tsv
	menu_load
	check_auto
	menu_run
	menu_save
}

Menu_Post_Render() {
	echoL "Main Menu"
	echoR "System Software"
	return 1
}

BinutilsPass1() {
	mkdir -p $HERE/../Packages
	echoL "Binutils-2.45 Pass 1"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}

GCCPass1() {
	echoL "GCC-15.2.0 Pass 1"
	lfs_share_on
	run_as_lfs "$HERE/$EXEC_SCRIPT"
	root_share_on
	return_wait 1
	return 1
}




lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 0

Acl (2.3.2) - 363 KB:
Home page: https://savannah.nongnu.org/projects/acl
Download: https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz
MD5 sum: 590765dee95907dbc3c856f7255bd669

Attr (2.5.2) - 484 KB:
Home page: https://savannah.nongnu.org/projects/attr
Download: https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz
MD5 sum: 227043ec2f6ca03c0948df5517f9c927

Autoconf (2.72) - 1,360 KB:
Home page: https://www.gnu.org/software/autoconf/
Download: https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz
MD5 sum: 1be79f7106ab6767f18391c5e22be701

Automake (1.18.1) - 1,614 KB:
Home page: https://www.gnu.org/software/automake/
Download: https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz
MD5 sum: cea31dbf1120f890cbf2a3032cfb9a68

Bash (5.3) - 11,089 KB:
Home page: https://www.gnu.org/software/bash/
Download: https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz
MD5 sum: 977c8c0c5ae6309191e7768e28ebc951

Bc (7.0.3) - 464 KB:
Home page: https://github.com/gavinhoward
Download: https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz
MD5 sum: ad4db5a0eb4fdbb3f6813be4b6b3da74


Bison (3.8.2) - 2,752 KB:
Home page: https://www.gnu.org/software/bison/
Download: https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz
MD5 sum: c28f119f405a2304ff0a7ccdcc629713

Bzip2 (1.0.8) - 792 KB:
Download: https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
MD5 sum: 67e051268d0c475ea773822f7500d0e5

Coreutils (9.7) - 6,015 KB:
Home page: https://www.gnu.org/software/coreutils/
Download: https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz
MD5 sum: 6b7285faf7d5eb91592bdd689270d3f1

DejaGNU (1.6.3) - 608 KB:
Home page: https://www.gnu.org/software/dejagnu/
Download: https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz
MD5 sum: 68c5208c58236eba447d7d6d1326b821

Diffutils (3.12) - 1,894 KB:
Home page: https://www.gnu.org/software/diffutils/
Download: https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.xz
MD5 sum: d1b18b20868fb561f77861cd90b05de4

E2fsprogs (1.47.3) - 9,851 KB:
Home page: https://e2fsprogs.sourceforge.net/
Download: https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz
MD5 sum: 113d7a7ee0710d2a670a44692a35fd2e

Elfutils (0.193) - 11,695 KB:
Home page: https://sourceware.org/elfutils/
Download: https://sourceware.org/ftp/elfutils/0.193/elfutils-0.193.tar.bz2
MD5 sum: ceefa052ded950a4c523688799193a44

Expat (2.7.1) - 485 KB:
Home page: https://libexpat.github.io/
Download: https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz
MD5 sum: 9f0c266ff4b9720beae0c6bd53ae4469

Expect (5.45.4) - 618 KB:
Home page: https://core.tcl.tk/expect/
Download: https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz
MD5 sum: 00fce8de158422f5ccd2666512329bd2

File (5.46) - 1,283 KB:
Home page: https://www.darwinsys.com/file/
Download: https://astron.com/pub/file/file-5.46.tar.gz
MD5 sum: 459da2d4b534801e2e2861611d823864

Findutils (4.10.0) - 2,189 KB:
Home page: https://www.gnu.org/software/findutils/
Download: https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz
MD5 sum: 870cfd71c07d37ebe56f9f4aaf4ad872

Flex (2.6.4) - 1,386 KB:
Home page: https://github.com/westes/flex
Download: https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
MD5 sum: 2882e3179748cc9f9c23ec593d6adc8d

Flit-core (3.12.0) - 53 KB:
Home page: https://pypi.org/project/flit-core/
Download: https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz
MD5 sum: c538415c1f27bd69cbbbf3cdd5135d39

Gawk (5.3.2) - 3,662 KB:
Home page: https://www.gnu.org/software/gawk/
Download: https://ftp.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz
MD5 sum: b7014650c5f45e5d4837c31209dc0037

GDBM (1.26) - 1,198 KB:
Home page: https://www.gnu.org/software/gdbm/
Download: https://ftp.gnu.org/gnu/gdbm/gdbm-1.26.tar.gz
MD5 sum: aaa600665bc89e2febb3c7bd90679115

Gettext (0.26) - 9,926 KB:
Home page: https://www.gnu.org/software/gettext/
Download: https://ftp.gnu.org/gnu/gettext/gettext-0.26.tar.xz
MD5 sum: 8e14e926f088e292f5f2bce95b81d10e

Glibc (2.42) - 19,464 KB:
Home page: https://www.gnu.org/software/libc/
Download: https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz
MD5 sum: 23c6f5a27932b435cae94e087cb8b1f5

[Note] Note
The Glibc developers maintain a Git branch containing patches considered worthy for Glibc-2.42 but unfortunately developed after Glibc-2.42 release. The LFS editors will issue a security advisory if any security fix is added into the branch, but no actions will be taken for other newly added patches. You may review the patches yourself and incorporate some patches if you consider them important.

Gperf (3.3) - 1,789 KB:
Home page: https://www.gnu.org/software/gperf/
Download: https://ftp.gnu.org/gnu/gperf/gperf-3.3.tar.gz
MD5 sum: 31753b021ea78a21f154bf9eecb8b079

Grep (3.12) - 1,874 KB:
Home page: https://www.gnu.org/software/grep/
Download: https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz
MD5 sum: 5d9301ed9d209c4a88c8d3a6fd08b9ac

Groff (1.23.0) - 7,259 KB:
Home page: https://www.gnu.org/software/groff/
Download: https://ftp.gnu.org/gnu/groff/groff-1.23.0.tar.gz
MD5 sum: 5e4f40315a22bb8a158748e7d5094c7d

GRUB (2.12) - 6,524 KB:
Home page: https://www.gnu.org/software/grub/
Download: https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz
MD5 sum: 60c564b1bdc39d8e43b3aab4bc0fb140

Gzip (1.14) - 865 KB:
Home page: https://www.gnu.org/software/gzip/
Download: https://ftp.gnu.org/gnu/gzip/gzip-1.14.tar.xz
MD5 sum: 4bf5a10f287501ee8e8ebe00ef62b2c2

Iana-Etc (20250807) - 592 KB:
Home page: https://www.iana.org/protocols
Download: https://github.com/Mic92/iana-etc/releases/download/20250807/iana-etc-20250807.tar.gz
MD5 sum: de0a909103d4ff59d1424c5ec7ac9e4a

Inetutils (2.6) - 1,724 KB:
Home page: https://www.gnu.org/software/inetutils/
Download: https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz
MD5 sum: 401d7d07682a193960bcdecafd03de94

Intltool (0.51.0) - 159 KB:
Home page: https://freedesktop.org/wiki/Software/intltool
Download: https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz
MD5 sum: 12e517cac2b57a0121cda351570f1e63

IPRoute2 (6.16.0) - 910 KB:
Home page: https://www.kernel.org/pub/linux/utils/net/iproute2/
Download: https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.16.0.tar.xz
MD5 sum: 80e1f91bf59d572acc15d5c6eb4f3e7c

Jinja2 (3.1.6) - 240 KB:
Home page: https://jinja.palletsprojects.com/en/3.1.x/
Download: https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz
MD5 sum: 66d4c25ff43d1deaf9637ccda523dec8

Kbd (2.8.0) - 1,448 KB:
Home page: https://kbd-project.org/
Download: https://www.kernel.org/pub/linux/utils/kbd/kbd-2.8.0.tar.xz
MD5 sum: 24b5d24f7483726b88f214dc6c77aa41

Kmod (34.2) - 434 KB:
Home page: https://github.com/kmod-project/kmod
Download: https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz
MD5 sum: 36f2cc483745e81ede3406fa55e1065a

Less (679) - 857 KB:
Home page: https://www.greenwoodsoftware.com/less/
Download: https://www.greenwoodsoftware.com/less/less-679.tar.gz
MD5 sum: 0386dc14f6a081a94dfb4c2413864eed

LFS-Bootscripts (20250827) - 34 KB:
Download: https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz
MD5 sum: 3f661c64c2dfb55025767ed56074d059

Libcap (2.76) - 195 KB:
Home page: https://sites.google.com/site/fullycapable/
Download: https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.76.tar.xz
MD5 sum: 449ade7d620b5c4eeb15a632fbaa4f74

Libffi (3.5.2) - 1,390 KB:
Home page: https://sourceware.org/libffi/
Download: https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz
MD5 sum: 92af9efad4ba398995abf44835c5d9e9

Libpipeline (1.5.8) - 1046 KB:
Home page: https://libpipeline.nongnu.org/
Download: https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz
MD5 sum: 17ac6969b2015386bcb5d278a08a40b5

Libtool (2.5.4) - 1,033 KB:
Home page: https://www.gnu.org/software/libtool/
Download: https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz
MD5 sum: 22e0a29df8af5fdde276ea3a7d351d30

Libxcrypt (4.4.38) - 612 KB:
Home page: https://github.com/besser82/libxcrypt/
Download: https://github.com/besser82/libxcrypt/releases/download/v4.4.38/libxcrypt-4.4.38.tar.xz
MD5 sum: 1796a5d20098e9dd9e3f576803c83000

Linux (6.16.1) - 149,042 KB:
Home page: https://www.kernel.org/
Download: https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz
MD5 sum: 32d45755e4b39d06e9be58f6817445ee

[Note] Note
The Linux kernel is updated quite frequently, many times due to discoveries of security vulnerabilities. The latest available stable kernel version may be used, unless the errata page says otherwise.

For users with limited speed or expensive bandwidth who wish to update the Linux kernel, a baseline version of the package and patches can be downloaded separately. This may save some time or cost for a subsequent patch level upgrade within a minor release.

Lz4 (1.10.0) - 379 KB:
Home page: https://lz4.org/
Download: https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz
MD5 sum: dead9f5f1966d9ae56e1e32761e4e675

M4 (1.4.20) - 1,997 KB:
Home page: https://www.gnu.org/software/m4/
Download: https://ftp.gnu.org/gnu/m4/m4-1.4.20.tar.xz
MD5 sum: 6eb2ebed5b24e74b6e890919331d2132

Make (4.4.1) - 2,300 KB:
Home page: https://www.gnu.org/software/make/
Download: https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
MD5 sum: c8469a3713cbbe04d955d4ae4be23eeb

Man-DB (2.13.1) - 2,061 KB:
Home page: https://www.nongnu.org/man-db/
Download: https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz
MD5 sum: b6335533cbeac3b24cd7be31fdee8c83

Man-pages (6.15) - 1,817 KB:
Home page: https://www.kernel.org/doc/man-pages/
Download: https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.15.tar.xz
MD5 sum: 16f68d70139dd2bbcae4102be4705753

MarkupSafe (3.0.2) - 21 KB:
Home page: https://palletsprojects.com/p/markupsafe/
Download: https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.2.tar.gz
MD5 sum: cb0071711b573b155cc8f86e1de72167

Meson (1.8.3) - 2,282:
Home page: https://mesonbuild.com
Download: https://github.com/mesonbuild/meson/releases/download/1.8.3/meson-1.8.3.tar.gz
MD5 sum: 08221d2f515e759686f666ff6409a903


Ncurses (6.5-20250809) - 3,703 KB:
Home page: https://www.gnu.org/software/ncurses/
Download: https://invisible-mirror.net/archives/ncurses/current/ncurses-6.5-20250809.tgz
MD5 sum: 679987405412f970561cc85e1e6428a2

Ninja (1.13.1) - 286 KB:
Home page: https://ninja-build.org/
Download: https://github.com/ninja-build/ninja/archive/v1.13.1/ninja-1.13.1.tar.gz
MD5 sum: c35f8f55f4cf60f1a916068d8f45a0f8

OpenSSL (3.5.2) - 51,934 KB:
Home page: https://www.openssl-library.org/
Download: https://github.com/openssl/openssl/releases/download/openssl-3.5.2/openssl-3.5.2.tar.gz
MD5 sum: 890fc59f86fc21b5e4d1c031a698dbde

Packaging (25.0) - 162 KB:
Home page: https://pypi.org/project/packaging/
Download: https://files.pythonhosted.org/packages/source/p/packaging/packaging-25.0.tar.gz
MD5 sum: ab0ef21ddebe09d1803575120d3f99f8

Patch (2.8) - 886 KB:
Home page: https://savannah.gnu.org/projects/patch/
Download: https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz
MD5 sum: 149327a021d41c8f88d034eab41c039f

Perl (5.42.0) - 14,084 KB:
Home page: https://www.perl.org/
Download: https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
MD5 sum: 7a6950a9f12d01eb96a9d2ed2f4e0072

Pkgconf (2.5.1) - 321 KB:
Home page: https://github.com/pkgconf/pkgconf
Download: https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz
MD5 sum: 3291128c917fdb8fccd8c9e7784b643b

Procps (4.0.5) - 1,483 KB:
Home page: https://gitlab.com/procps-ng/procps/
Download: https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.5.tar.xz
MD5 sum: 90803e64f51f192f3325d25c3335d057

Psmisc (23.7) - 423 KB:
Home page: https://gitlab.com/psmisc/psmisc
Download: https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz
MD5 sum: 53eae841735189a896d614cba440eb10

Python (3.13.7) - 22,236 KB:
Home page: https://www.python.org/
Download: https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz
MD5 sum: 256cdb3bbf45cdce7499e52ba6c36ea3

Python Documentation (3.13.7) - 10,183 KB:
Download: https://www.python.org/ftp/python/doc/3.13.7/python-3.13.7-docs-html.tar.bz2
MD5 sum: b84c0d81b2758398bb7f5b7411d3d908

Readline (8.3) - 3,340 KB:
Home page: https://tiswww.case.edu/php/chet/readline/rltop.html
Download: https://ftp.gnu.org/gnu/readline/readline-8.3.tar.gz
MD5 sum: 25a73bfb2a3ad7146c5e9d4408d9f6cd

Sed (4.9) - 1,365 KB:
Home page: https://www.gnu.org/software/sed/
Download: https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz
MD5 sum: 6aac9b2dbafcd5b7a67a8a9bcb8036c3

Setuptools (80.9.0) - 1,290 KB:
Home page: https://pypi.org/project/setuptools/
Download: https://pypi.org/packages/source/s/setuptools/setuptools-80.9.0.tar.gz
MD5 sum: 82e1d67883b713f9493659b50d13b436

Shadow (4.18.0) - 2,293 KB:
Home page: https://github.com/shadow-maint/shadow/
Download: https://github.com/shadow-maint/shadow/releases/download/4.18.0/shadow-4.18.0.tar.xz
MD5 sum: 30ef46f54363db1d624587be68794ef2

Sysklogd (2.7.2) - 474 KB:
Home page: https://www.infodrom.org/projects/sysklogd/
Download: https://github.com/troglobit/sysklogd/releases/download/v2.7.2/sysklogd-2.7.2.tar.gz
MD5 sum: af60786956a2dc84054fbf46652e515e

Systemd (257.8) - 16,002 KB:
Home page: https://www.freedesktop.org/wiki/Software/systemd/
Download: https://github.com/systemd/systemd/archive/v257.8/systemd-257.8.tar.gz
MD5 sum: 25fe5d328e22641254761f1baa74cee0

Systemd Man Pages (257.8) - 736 KB:
Home page: https://www.freedesktop.org/wiki/Software/systemd/
Download: https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-257.8.tar.xz
MD5 sum: a44063e2ec0cf4adfd2ed5c9e9e095c5

[Note] Note
The Linux From Scratch team generates its own tarball of the man pages using the systemd source. This is done in order to avoid unnecessary dependencies.

SysVinit (3.14) - 236 KB:
Home page: https://savannah.nongnu.org/projects/sysvinit
Download: https://github.com/slicer69/sysvinit/releases/download/3.14/sysvinit-3.14.tar.xz
MD5 sum: bc6890b975d19dc9db42d0c7364dd092

Tar (1.35) - 2,263 KB:
Home page: https://www.gnu.org/software/tar/
Download: https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz
MD5 sum: a2d8042658cfd8ea939e6d911eaf4152

Tcl (8.6.16) - 11,406 KB:
Home page: https://tcl.sourceforge.net/
Download: https://downloads.sourceforge.net/tcl/tcl8.6.16-src.tar.gz
MD5 sum: eaef5d0a27239fb840f04af8ec608242

Tcl Documentation (8.6.16) - 1,169 KB:
Download: https://downloads.sourceforge.net/tcl/tcl8.6.16-html.tar.gz
MD5 sum: 750c221bcb6f8737a6791c1fbe98b684

Texinfo (7.2) - 6,259 KB:
Home page: https://www.gnu.org/software/texinfo/
Download: https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz
MD5 sum: 11939a7624572814912a18e76c8d8972

Time Zone Data (2025b) - 454 KB:
Home page: https://www.iana.org/time-zones
Download: https://www.iana.org/time-zones/repository/releases/tzdata2025b.tar.gz
MD5 sum: ad65154c48c74a9b311fe84778c5434f

Udev-lfs Tarball (udev-lfs-20230818) - 10 KB:
Download: https://anduin.linuxfromscratch.org/LFS/udev-lfs-20230818.tar.xz
MD5 sum: acd4360d8a5c3ef320b9db88d275dae6

Util-linux (2.41.1) - 9,382 KB:
Home page: https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/
Download: https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz
MD5 sum: 7e5e68845e2f347cf96f5448165f1764

Vim (9.1.1629) - 18,317 KB:
Home page: https://www.vim.org
Download: https://github.com/vim/vim/archive/v9.1.1629/vim-9.1.1629.tar.gz
MD5 sum: 4f856c3233c1c4570bc17572e4f9e8e4

[Note] Note
The version of vim changes daily. To get the latest version, go to https://github.com/vim/vim/tags.

Wheel (0.46.1) - 54 KB:
Home page: https://pypi.org/project/wheel/
Download: https://pypi.org/packages/source/w/wheel/wheel-0.46.1.tar.gz
MD5 sum: 65e09ee84af36821e3b1e9564aa91bd5

XML::Parser (2.47) - 276 KB:
Home page: https://github.com/chorny/XML-Parser
Download: https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz
MD5 sum: 89a8e82cfd2ad948b349c0a69c494463

Xz Utils (5.8.1) - 1,428 KB:
Home page: https://tukaani.org/xz
Download: https://github.com//tukaani-project/xz/releases/download/v5.8.1/xz-5.8.1.tar.xz
MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3

Zlib (1.3.1) - 1,478 KB:
Home page: https://zlib.net/
Download: https://zlib.net/fossils/zlib-1.3.1.tar.gz
MD5 sum: 9855b6d802d7fe5b7bd5b196a2271655

Zstd (1.5.7) - 2,378 KB:
Home page: https://facebook.github.io/zstd/
Download: https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz
MD5 sum: 780fc1896922b1bc52a4e90980cdda48

