#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Ninja (1.13.1) - 286 KB:
	# Home page: https://ninja-build.org/
	# Download: https://github.com/ninja-build/ninja/archive/v1.13.1/ninja-1.13.1.tar.gz
	# MD5 sum: c35f8f55f4cf60f1a916068d8f45a0f8
	echoR "System Software"

	echoL "Downloading Ninja (1.13.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/ninja-build/ninja/archive/v1.13.1/ninja-1.13.1.tar.gz ninja-1.13.1.tar.gz
	cp ../Packages/ninja-1.13.1.tar.gz /sources

	echoL "Unpack Ninja (1.13.1)..."
	sleep 2
	cd /sources
	rm -fR ninja-1.13.1
	tar -vxsf ninja-1.13.1.tar.gz
	cd ninja-1.13.1

	echoL "Building Ninja (1.13.1)..."
	sleep 2
	export NINJAJOBS=4
	sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc
	python3 configure.py --bootstrap --verbose

	echoL "Installing Ninja (1.13.1)..."
	sleep 2
	install -vm755 ninja /usr/bin/
	install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
	install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR ninja-1.13.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
