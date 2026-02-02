#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Recommended
	#	cURL-8.15.0 (needed to use Git over http, https, ftp or ftps)

	# Optional
	#	Apache-2.4.65 (for some tests),
	#	Fcron-3.4.0 (runtime, for scheduling git maintenance jobs)
	#	GnuPG-2.4.8 (runtime, may be used to sign Git commits or tags, or verify the signatures of them)
	#	OpenSSH-10.0p1 (runtime, needed to use Git over ssh)
	#	pcre2-10.45
	#	Subversion-1.14.5 with Perl bindings (runtime, for git svn)
	#	Tk-8.6.16 (gitk, a simple Git repository viewer, uses Tk at runtime)
	#	Valgrind-3.25.1, 
	#	Authen::SASL (runtime, for git send-email)
	#	IO-Socket-SSL-2.095 (runtime, for git send-email to connect to a SMTP server with SSL encryption)

	# Optional (to create the man pages, html docs and other docs)
	#	xmlto-0.0.29 and asciidoc-10.2.1
	#	dblatex (for the PDF version of the user manual)
	#	and docbook2x to create info pages

main () {

	# Download (HTTP): https://www.kernel.org/pub/software/scm/git/git-2.50.1.tar.xz
	# Download MD5 sum: 2cb96fae126d66f8ff23a68f8dd5d748
	# Download size: 7.5 MB
	# Estimated disk space required: 453MB (with downloaded documentation; add 19 MB for building docs; add 21 MB for tests)
	# Estimated build time: 0.3 SBU (with parallelism=4; add 1.0 SBU for building docs, and up to 7 SBU (disk speed dependent) for tests)
	echoR "Group 3 Support Applications"

	echoL "Downloading Git (2.50.1)..."
	sleep 2
	cd "/root/lfs/B-03-Support Applications"
	../bash/Download.sh https://www.kernel.org/pub/software/scm/git/git-2.50.1.tar.xz git-2.50.1.tar.xz
	cp ../Packages/git-2.50.1.tar.xz /sources
	# Additional Downloads
	../bash/Download.sh https://www.kernel.org/pub/software/scm/git/git-manpages-2.50.1.tar.xz git-manpages-2.50.1.tar.xz
	cp ../Packages/git-manpages-2.50.1.tar.xz /sources

	../bash/Download.sh https://www.kernel.org/pub/software/scm/git/git-htmldocs-2.50.1.tar.xz git-htmldocs-2.50.1.tar.xz
	cp ../Packages/git-htmldocs-2.50.1.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Git (2.50.1)..."
	sleep 2
	cd /sources
	rm -fR git-2.50.1
	tar -vxsf git-2.50.1.tar.xz
	cd git-2.50.1

	echoL "Building Git (2.50.1)..."
	sleep 2
	./configure --prefix=/usr           \
		--with-gitconfig=/etc/gitconfig \
		--with-python=python3
	make

	echoL "Testing Git (2.50.1)..."
	sleep 2
	GIT_UNZIP=nonexist make test

	echoL "Installing Git (2.50.1)..."
	sleep 2
	make perllibdir=/usr/lib/perl5/5.42/site_perl install
	tar -xf ../git-manpages-2.50.1.tar.xz -C /usr/share/man --no-same-owner --no-overwrite-dir

	mkdir -vp /usr/share/doc/git-2.50.1
	tar -xf ../git-htmldocs-2.50.1.tar.xz -C /usr/share/doc/git-2.50.1 --no-same-owner --no-overwrite-dir
	find /usr/share/doc/git-2.50.1 -type d -exec chmod 755 {} \;
	find /usr/share/doc/git-2.50.1 -type f -exec chmod 644 {} \;

	mkdir -vp /usr/share/doc/git-2.50.1/man-pages/{html,text}
	mv        /usr/share/doc/git-2.50.1/{git*.adoc,man-pages/text}
	mv        /usr/share/doc/git-2.50.1/{git*.,index.,man-pages/}html

	mkdir -vp /usr/share/doc/git-2.50.1/technical/{html,text}
	mv        /usr/share/doc/git-2.50.1/technical/{*.adoc,text}
	mv        /usr/share/doc/git-2.50.1/technical/{*.,}html

	mkdir -vp /usr/share/doc/git-2.50.1/howto/{html,text}
	mv        /usr/share/doc/git-2.50.1/howto/{*.adoc,text}
	mv        /usr/share/doc/git-2.50.1/howto/{*.,}html

	sed -i '/^<a href=/s|howto/|&html/|' /usr/share/doc/git-2.50.1/howto-index.html
	sed -i '/^\* link:/s|howto/|&html/|' /usr/share/doc/git-2.50.1/howto-index.adoc

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR git-2.50.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
