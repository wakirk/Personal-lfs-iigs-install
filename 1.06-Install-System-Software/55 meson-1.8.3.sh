#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	# Meson (1.8.3) - 2,282:
	# Home page: https://mesonbuild.com
	# Download: https://github.com/mesonbuild/meson/releases/download/1.8.3/meson-1.8.3.tar.gz
	# MD5 sum: 08221d2f515e759686f666ff6409a903
	echoR "System Software"

	echoL "Downloading Meson (1.8.3)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://github.com/mesonbuild/meson/releases/download/1.8.3/meson-1.8.3.tar.gz meson-1.8.3.tar.gz
	cp ../Packages/meson-1.8.3.tar.gz /sources

	echoL "Unpack Meson (1.8.3)..."
	sleep 2
	cd /sources
	rm -fR meson-1.8.3
	tar -vxsf meson-1.8.3.tar.gz
	cd meson-1.8.3

	echoL "Building Meson (1.8.3)..."
	sleep 2
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

	echoL "Installing Meson (1.8.3)..."
	sleep 2
	pip3 install --no-index --find-links dist meson
	install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
	install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR meson-1.8.3

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
