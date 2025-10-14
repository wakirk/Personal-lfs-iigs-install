#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	cd /sources 
	rm -fR  tmux-3.5a
	tar -vxsf tmux-3.5a.tar.gz
	cd  tmux-3.5a
	./autogen.sh
	./configure --prefix=/usr
	make
	make install
	localedef -i en_US -f UTF-8 en_US.UTF-8

	cd /sources
	rm -fR  tmux-3.5a

}

main

exit 0

# cat >/etc/profile.d/10-locale.sh <<'EOF'
# # LFS default locale
# export LANG=en_US.UTF-8
# export LC_CTYPE=en_US.UTF-8
# EOF
# chmod 644 /etc/profile.d/10-locale.sh

