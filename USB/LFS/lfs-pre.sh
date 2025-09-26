#!/bin/bash

clear
mkdir /mnt/net/d -p
mount -t cifs //192.168.1.237/D /mnt/net/d -o username=,password=,vers=3.0,uid=0,gid=0
lsblk
ln -s /mnt/net/d/LFS /root/lfs
cd /root/lfs
ls -l
/root/lfs/bash/telnet-setup.sh
grep -qxF 'export LFS=/mnt/lfs' /root/.bash_profile || echo 'export LFS=/mnt/lfs' >> /root/.bash_profile
grep -qxF 'umask 022'           /root/.bash_profile || echo 'umask 022'           >> /root/.bash_profile
