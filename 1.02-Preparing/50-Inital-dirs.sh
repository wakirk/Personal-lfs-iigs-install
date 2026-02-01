#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.02-Preparing

echoL "Initial Directories..."

chown root:root $LFS
chmod 755 $LFS

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

mkdir -p $LFS/home
mkdir -p $LFS/usr
mkdir -p $LFS/tmp
mkdir -p $LFS/usr/src
chmod 1777 $LFS/lfs/tmp

echo LFS = $LFS
ls $LFS -l
echo umask:
umask

exit 1
