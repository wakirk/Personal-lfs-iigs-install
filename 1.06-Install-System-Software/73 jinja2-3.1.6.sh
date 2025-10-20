#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Jinja2 (3.1.6) - 240 KB:
	# Home page: https://jinja.palletsprojects.com/en/3.1.x/
	# Download: https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz
	# MD5 sum: 66d4c25ff43d1deaf9637ccda523dec8
	echoR "System Software"

	echoL "Downloading Jinja2 (3.1.6)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz jinja2-3.1.6.tar.gz
	cp ../Packages/jinja2-3.1.6.tar.gz /sources

	echoL "Unpack Jinja2 (3.1.6)..."
	sleep 2
	cd /sources
	rm -fR jinja2-3.1.6
	tar -vxsf jinja2-3.1.6.tar.gz
	cd jinja2-3.1.6

	echoL "Building Jinja2 (3.1.6)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing Jinja2 (3.1.6)..."
	sleep 2
	pip3 install --no-index --find-links dist Jinja2

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR jinja2-3.1.6

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
