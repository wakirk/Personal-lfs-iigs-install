#!/bin/bash

clear
mkdir /mnt/net/d -p
mount -t cifs //192.168.1.237/D /mnt/net/d -o username=wakirk2002@gmail.com,password=pod4html,vers=3.0,uid=0,gid=0
lsblk
ln -s /mnt/net/d/LFS /root/lfs
cd /root/lfs
ls -l
/root/lfs/Host/telnet-setup.sh
