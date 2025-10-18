Ninja (1.13.1) - 286 KB:
Home page: https://ninja-build.org/

Download: https://github.com/ninja-build/ninja/archive/v1.13.1/ninja-1.13.1.tar.gz

MD5 sum: c35f8f55f4cf60f1a916068d8f45a0f8




/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	Utils (5.8.1) - 1,428 KB:
	Home page: https://tukaani.org/xz
	Download: https: .tar.xz
	MD5 sum: cf5e1feb023d22c6bdaa30e84ef3abe3
	echoR "System Software"

	echoL "Downloading ------- ( ) ..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://*.tar.xz *.tar.xz
	cp ../Packages/-.tar.xz /sources

	echoL "Unpack ------- ( ) ..."
	sleep 2
	cd /sources
	rm -fR
	tar -vxsf
	cd 

	echoL "Building ------- ( ) ..."
	sleep 2

	echoL "Testing ------- ( ) ..."
	sleep 2
	/bin/bash

	echoL "Installing ------- ( ) ..."
	sleep 2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR 

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1












8.56.1. Installation of Ninja
When run, ninja normally utilizes the greatest possible number of processes in parallel. By default this is the number of cores on the system, plus two. This may overheat the CPU, or make the system run out of memory. When ninja is invoked from the command line, passing the -jN parameter will limit the number of parallel processes. Some packages embed the execution of ninja, and do not pass the -j parameter on to it.

Using the optional procedure below allows a user to limit the number of parallel processes via an environment variable, NINJAJOBS. For example, setting:

export NINJAJOBS=4
will limit ninja to four parallel processes.

If desired, make ninja recognize the environment variable NINJAJOBS by running the stream editor:

sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc
Build Ninja with:

python3 configure.py --bootstrap --verbose
The meaning of the build option:

--bootstrap
This parameter forces Ninja to rebuild itself for the current system.

--verbose
This parameter makes configure.py show the progress building Ninja.

The package tests cannot run in the chroot environment. They require cmake. But the basic function of this package is already tested by rebuilding itself (with the --bootstrap option) anyway.

Install the package:

install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja
8.56.2. Contents of Ninja
