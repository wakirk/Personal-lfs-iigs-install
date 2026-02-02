#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
main () {

	echoR "BLFS Xorg Setup Build"

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

# Create an /etc/profile.d/xorg.sh configuration file containing these variables as the root user:
cat > /etc/profile.d/xorg.sh << EOF
XORG_PREFIX="$XORG_PREFIX"
XORG_CONFIG="--prefix=\$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
export XORG_PREFIX XORG_CONFIG
EOF
chmod 644 /etc/profile.d/xorg.sh

mkdir -p /etc/sudoers.d
# If you've installed Sudo-1.9.17p2, ensure that XORG_PREFIX and XORG_CONFIG are available in the sudo environment. As the root user, run the following command:
cat > /etc/sudoers.d/xorg << EOF
Defaults env_keep += XORG_PREFIX
Defaults env_keep += XORG_CONFIG
EOF

	echoL "BLFS Xorg Setup Build Environment Complete."
	sleep 2
	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
