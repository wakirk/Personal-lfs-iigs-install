#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	#	/usr build

	# Download (HTTP): https://static.rust-lang.org/dist/rustc-1.89.0-src.tar.xz
	# Download MD5 sum: 982f087479302e6d91432efc81852b00
	# Download size: 256 MB
	# Estimated disk space required: 9.4 GB (252 MB installed); add 7.4 GB if running the tests
	# Estimated build time: 9.0 SBU (including download time; add 15 SBU for tests, both using parallelism=8)	echoR "Group 5 Xorg Libraries and Mesa"
	echoR "Group 5 Xorg Libraries and Mesa"
	echoL "Downloading Rustc (1.89.0)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://static.rust-lang.org/dist/rustc-1.89.0-src.tar.xz rustc-1.89.0-src.tar.xz
	cp ../Packages/rustc-1.89.0-src.tar.xz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Rustc (1.89.0)..."
	sleep 2
	cd /sources
	rm -fR rustc-1.89.0-src
	tar -vxsf rustc-1.89.0-src.tar.xz
	cd rustc-1.89.0-src

	echoL "Building Rustc (1.89.0)..."
	sleep 2

	cat << EOF > bootstrap.toml
# See bootstrap.toml.example for more possible options,
# and see src/bootstrap/defaults/bootstrap.dist.toml for a few options
# automatically set when building from a release tarball
# (unfortunately, we have to override many of them).

# Tell x.py the editors have reviewed the content of this file
# and updated it to follow the major changes of the building system,
# so x.py will not warn us to do such a review.
change-id = 142379

[llvm]
# When using system llvm prefer shared libraries
link-shared = true

# If building the shipped LLVM source, only enable the x86 target
# instead of all the targets supported by LLVM.
targets = "X86"

[build]
description = "for BLFS 12.4"

# Omit docs to save time and space (default is to build them).
docs = false

# Do not query new versions of dependencies online.
locked-deps = true

# Specify which extended tools (those from the default install).
tools = ["cargo", "clippy", "rustdoc", "rustfmt"]

[install]
prefix = "/usr"
docdir = "share/doc/rustc-1.89.0"

[rust]
channel = "stable"

# Enable the same optimizations as the official upstream build.
lto = "thin"
codegen-units = 1

# Don't build lld which does not belong to this package and seems not
# so useful for BLFS.  Even if it turns out to be really useful we'd build
# it as a part of the LLVM package instead.
lld = false

# Don't build llvm-bitcode-linker which is only useful for the NVPTX
# backend that we don't enable.
llvm-bitcode-linker = false

[target.x86_64-unknown-linux-gnu]
llvm-config = "/usr/bin/llvm-config"

[target.i686-unknown-linux-gnu]
llvm-config = "/usr/bin/llvm-config"
EOF
	[ ! -e /usr/include/libssh2.h ] || export LIBSSH2_SYS_USE_PKG_CONFIG=1
	[ ! -e /usr/include/sqlite3.h ] || export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	./x.py build

	echoL "Testing Rustc (1.89.0)..."
	sleep 2
	./x.py test --verbose --no-fail-fast | tee rustc-testlog
	grep '^test result:' rustc-testlog |
	awk '{sum1 += $4; sum2 += $6} END { print sum1 " passed; " sum2 " failed" }'

	echoL "Installing Rustc (1.89.0)..."
	sleep 2
	./x.py install
	rm -fv /opt/rustc-1.89.0/share/doc/rustc-1.89.0/*.old   &&
	install -vm644 README.md                                \
		/opt/rustc-1.89.0/share/doc/rustc-1.89.0 &&

	install -vdm755 /usr/share/zsh/site-functions      &&
	ln -sfv /opt/rustc/share/zsh/site-functions/_cargo \
			/usr/share/zsh/site-functions

	mv -v /etc/bash_completion.d/cargo /usr/share/bash-completion/completions
	unset LIB{SSH2,SQLITE3}_SYS_USE_PKG_CONFIG

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR rustc-1.89.0-src

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
