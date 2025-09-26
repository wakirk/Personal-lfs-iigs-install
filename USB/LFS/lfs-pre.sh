#!/bin/bash

source userID.key

clear
mkdir /mnt/net/d -p
mount -t cifs $SHARE_ID $SHARE -o username=$SHARE_USER,password=$SHARE_PASS,vers=$SHARE_VERS,uid=0,gid=0
lsblk
ln -s /mnt/net/d/LFS /root/lfs
cd /root/lfs
ls -l
/root/lfs/bash/telnet-setup.sh
grep -qxF 'export LFS=/mnt/lfs' /root/.bash_profile || echo 'export LFS=/mnt/lfs' >> /root/.bash_profile
grep -qxF 'umask 022'           /root/.bash_profile || echo 'umask 022'           >> /root/.bash_profile

