#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.01-Host


echoR "Configuring Host"
echoL "Installing Build System..."

# Core headers & toolchain
pacman -S --noconfirm --overwrite '/usr/include/linux/*' linux-api-headers
pacman -S --noconfirm gcc make patch glibc gcc-libs

# Parser/build tools required by LFS
pacman -S --noconfirm bison texinfo flex pkgconf

# Compression stacks (binutils BFD wants these headers)
pacman -S --noconfirm --overwrite '/usr/include/*' zstd zlib xz bzip2

# Optional system packages (only if you need them on the live host)
pacman -S --noconfirm linux linux-firmware
pacman -S --noconfirm parted dosfstools e2fsprogs rsync

printf '%s\n' '#!/bin/sh' 'exec bison -y "$@"' > /usr/bin/yacc
chmod +x /usr/bin/yacc


exit 1
