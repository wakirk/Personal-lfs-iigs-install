#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# [Important] Important
	# Users tend to base their passwords on regular words of the spoken language,
	# and crackers know that. CrackLib is intended to filter out such bad passwords at the
	# source using a dictionary created from word lists. To accomplish this, the word list(s)
	# for use with CrackLib must be an exhaustive list of words and word-based keystroke combinations
	# likely to be chosen by users of the system as (guessable) passwords.

	# The default word list recommended above for downloading mostly satisfies this role in
	# English-speaking countries. In other situations, it may be necessary to download (or even
	# create) additional word lists.

	# Note that word lists suitable for spell-checking are not usable as CrackLib word lists in
	# countries with non-Latin based alphabets, because of “word-based keystroke combinations”
	# that make bad passwords.

main () {

	# Package Information
	# Download (HTTP): https://github.com/cracklib/cracklib/releases/download/v2.10.3/cracklib-2.10.3.tar.xz
	# Download MD5 sum: e8ea2b86de774fc09fdd0f2829680b19
	# Download size: 456 KB
	# Estimated disk space required: 5.0 MB
	# Estimated build time: less than 0.1 SBU

	# Additional Downloads
	# Recommended word list for English-speaking countries:
	# Download (HTTP): https://github.com/cracklib/cracklib/releases/download/v2.10.3/cracklib-words-2.10.3.xz
	# Download MD5 sum: f27804022dbf2682a7f7c353317f9a53
	# Download size: 4.0 MB

	# There are additional word lists available for download, e.g., 
	# from https://www.skullsecurity.org/wiki/Passwords. 
	# CrackLib can utilize as many, or as few word lists you choose to install.
	echoR "Group 1 Library Foundation"

	echoL "Downloading CrackLib (2.10.3)..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	../bash/Download.sh https://github.com/cracklib/cracklib/releases/download/v2.10.3/cracklib-2.10.3.tar.xz cracklib-2.10.3.tar.xz
	cp ../Packages/cracklib-2.10.3.tar.xz /sources

	../bash/Download.sh https://github.com/cracklib/cracklib/releases/download/v2.10.3/cracklib-words-2.10.3.xz cracklib-words-2.10.3.xz
	cp ../Packages/cracklib-words-2.10.3.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack CrackLib (2.10.3)..."
	sleep 2
	cd /sources
	rm -fR cracklib-2.10.3
	tar -vxsf cracklib-2.10.3.tar.xz
	cd cracklib-2.10.3

	echoL "Building CrackLib (2.10.3)..."
	sleep 2
	CPPFLAGS+=' -I /usr/include/python3.13' \
	./configure --prefix=/usr               \
		--disable-static                    \
		--with-default-dict=/usr/lib/cracklib/pw_dict &&
	make

	echoL "Installing CrackLib (2.10.3)..."
	sleep 2
	make install
	# Issue the following commands as the root user to install the recommended word list and
	# create the CrackLib dictionary. Other word lists (text based, one word per line) can also
	# be used by simply installing them into /usr/share/dict and adding them to the create-cracklib-dict
	# command.
	echoL "Downloading Word lists..."
	sleep 2
	cd "/root/lfs/B-01-Library Foundation"
	mkdir -p /sources/cracklib-2.10.3/words
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/john.txt.bz2 john.txt.bz2
	cp ../Packages/john.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/cain.txt.bz2 cain.txt.bz2
	cp ../Packages/cain.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/conficker.txt.bz2 conficker.txt.bz2
	cp ../Packages/conficker.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/500-worst-passwords.txt.bz2 500-worst-passwords.txt.bz2
	cp ../Packages/500-worst-passwords.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/twitter-banned.txt.bz2 twitter-banned.txt.bz2
	cp ../Packages/twitter-banned.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2 rockyou.txt.bz2
	cp ../Packages/rockyou.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/phpbb.txt.bz2 phpbb.txt.bz2
	cp ../Packages/phpbb.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/myspace.txt.bz2 myspace.txt.bz2
	cp ../Packages/myspace.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/faithwriters.txt.bz2 faithwriters.txt.bz2
	cp ../Packages/faithwriters.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/elitehacker.txt.bz2 elitehacker.txt.bz2
	cp ../Packages/elitehacker.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/hak5.txt.bz2 hak5.txt.bz2
	cp ../Packages/hak5.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/alypaa.txt.bz2 alypaa.txt.bz2
	cp ../Packages/alypaa.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/facebook-pastebay.txt.bz2 facebook-pastebay.txt.bz2
	cp ../Packages/facebook-pastebay.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/porn-unknown.txt.bz2 porn-unknown.txt.bz2
	cp ../Packages/porn-unknown.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/tuscl.txt.bz2 tuscl.txt.bz2
	cp ../Packages/tuscl.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/facebook-phished.txt.bz2 facebook-phished.txt.bz2
	cp ../Packages/facebook-phished.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/carders.cc.txt.bz2 carders.cc.txt.bz2
	cp ../Packages/carders.cc.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	../bash/Download.sh http://downloads.skullsecurity.org/passwords/singles.org.txt.bz2 singles.org.txt.bz2
	cp ../Packages/singles.org.txt.bz2 /sources/cracklib-2.10.3/words
	sleep 3
	cd /sources/cracklib-2.10.3

	echoL "Building Word lists..."
	bzcat words/john.txt.bz2 >> words/fullist.txt
	bzcat words/cain.txt.bz2 >> words/fullist.txt
	bzcat words/conficker.txt.bz2 >> words/fullist.txt
	bzcat words/500-worst-passwords.txt.bz2 >> words/fullist.txt
	bzcat words/twitter-banned.txt.bz2 >> words/fullist.txt
	bzcat words/rockyou.txt.bz2 >> words/fullist.txt
	bzcat words/phpbb.txt.bz2 >> words/fullist.txt
	bzcat words/myspace.txt.bz2 >> words/fullist.txt
	bzcat words/faithwriters.txt.bz2 >> words/fullist.txt
	bzcat words/elitehacker.txt.bz2 >> words/fullist.txt
	bzcat words/hak5.txt.bz2 >> words/fullist.txt
	bzcat words/alypaa.txt.bz2 >> words/fullist.txt
	bzcat words/facebook-pastebay.txt.bz2 >> words/fullist.txt
	bzcat words/porn-unknown.txt.bz2 >> words/fullist.txt
	bzcat words/tuscl.txt.bz2 >> words/fullist.txt
	bzcat words/facebook-phished.txt.bz2 >> words/fullist.txt
	bzcat words/carders.cc.txt.bz2 >> words/fullist.txt
	bzcat words/singles.org.txt.bz2 >> words/fullist.txt
	xzcat ../cracklib-words-2.10.3.xz >> words/fullist.txt
	cat words/fullist.txt | sort | uniq > /usr/share/dict/cracklib-words

	echoL "Installing Word lists..."
	sleep 2
	ln -v -sf cracklib-words /usr/share/dict/words
	echo $(hostname) >>      /usr/share/dict/cracklib-extra-words
	install -v -m755 -d      /usr/lib/cracklib

	create-cracklib-dict     /usr/share/dict/cracklib-words \
							 /usr/share/dict/cracklib-extra-words
	# If desired, check the proper operation of the library as an unprivileged user
	# by issuing the following command:
	echoL "Testing CrackLib (2.10.3)..."
	sleep 2
	make test
	python3 -c 'import cracklib; cracklib.test()'

	# Important
	# If you are installing CrackLib after your LFS system has been completed and you have
	# the Shadow package installed, you must reinstall Shadow-4.18.0 if you wish to provide
	# strong password support on your system. If you are now going to install the
	# Linux-PAM-1.7.1 package, you may disregard this note as Shadow will be reinstalled
	# after the Linux-PAM installation.
	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR cracklib-2.10.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
