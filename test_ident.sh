#!/bin/bash
source lib/menu.lib   # In every script.

# function names named after the script file name.

clean_partition() {

# OH.... some scripts have the startup path hard coded, that's a NOPE!!!!!
#source /root/lfs/lib/menu.lib   # In every script.
#cd /root/lfs/1.02-Preparing

echoR "Preparing Partitions"
echoL "Removing any mounts..."
umount -v /dev/sda*

echoL "Cleaning Disk..."
# 1. Wipe first 10MB (MBR + GPT primary + boot code area)
dd if=/dev/zero of=/dev/sda bs=1M count=4096 status=progress

# 2. Wipe last 10MB (GPT backup + end-of-disk junk)
dd if=/dev/zero of=/dev/sda bs=1M count=4096 seek=$(( $(blockdev --getsz /dev/sda) / 2048 - 4096 )) status=progress

# 3. Clear filesystem/RAID/LVM signatures
wipefs -a /dev/sda
blockdev --rereadpt /dev/sda
udevadm settle
lsblk

echo "Drive Clean"
}

new_partition() {

# .... sigh..... 
#source /root/lfs/lib/menu.lib   # In every script.
#cd /root/lfs/1.02-Preparing

# Create EFI (2 GB, type EF00)
echoL "Creating EFI partition..."
sgdisk -n 1:0:+1G -t 1:EF00 -c 1:"EFI System" /dev/sda

# Create root (30 GB, type 8300)
echoL "Creating root partition..."
sgdisk -n 2:0:+50G -t 2:8300 -c 2:"LFS Root" /dev/sda

# Create swap (8 GB, type 8200)
echoL "Creating swap partition..."
sgdisk -n 3:0:+8G -t 3:8200 -c 3:"Linux Swap" /dev/sda

echoL "Cleaning residual data"
dd if=/dev/zero of=/dev/sda1 bs=1M count=4096 status=progress
dd if=/dev/zero of=/dev/sda2 bs=1M count=4096 status=progress
dd if=/dev/zero of=/dev/sda3 bs=1M count=4096 status=progress

# Write changes
sync
blockdev --rereadpt /dev/sda

}

file_system() {

# I really hope this isn't borked in all 80+ scripts.....
#source /root/lfs/lib/menu.lib   # In every script.
#cd /root/lfs/1.02-Preparing

echoL "Formatting File System..."

# Format EFI
echoL "Formatting EFI..."
mkfs.vfat -F32 -n EFI /dev/sda1

# Format root
echoL "Formatting root..."
mkfs.ext4 -L LFSROOT /dev/sda2

# Init swap
echoL "Formatting swap..."
mkswap -L LINUXSWAP /dev/sda3

}

mounting_system() {

# boy oh boy, I got a bad feeling about this kid....
#source /root/lfs/lib/menu.lib   # In every script.
#cd /root/lfs/1.02-Preparing

echoL "Mounting Volumes..."

# Prepare mountpoints
echoL "Making mount points..."
mkdir -pv /mnt/lfs

# Mount root
echoL "Mounting root..."
mount -v /dev/sda2 /mnt/lfs

# Prepare mountpoints
echoL "Making mount points..."
mkdir -pv /mnt/lfs/boot/efi

# Mount EFI
echoL "Mounting EFI..."
mount -v /dev/sda1 /mnt/lfs/boot/efi

echoL "Partitioning and formatting complete."
lsblk
lsblk -f /dev/sda

}

inital_dirs() {

# Weeping and nashing of teeth....
#source /root/lfs/lib/menu.lib   # In every script.
#cd /root/lfs/1.02-Preparing

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
chmod 1777 $LFS/tmp  #was  chmod 1777 $LFS/lfs/tmp  

echo LFS = $LFS
ls $LFS -l
echo umask:
umask

}

environment() {

# In the words of Captian Global from the SDF1, ..."Gonna be long trip."
#source /root/lfs/lib/menu.lib   # In every script.
#cd /root/lfs/1.02-Preparing

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

chown -v lfs:lfs "$LFS"/{usr{,/*},var,etc,tools,bin,lib,sbin}
#chown -v lfs $LFS/{usr{,/*},var,etc,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

cat > /home/lfs/.bash_profile << "EOF"
# Load your common env
[ -r ~/.bashrc ] && . ~/.bashrc

# Only replace the shell for *interactive* logins
case $- in
  *i*) exec env -i HOME="$HOME" TERM="$TERM" PS1='\u:\w\$ ' /bin/bash ;;
  *)   : ;;  # non-interactive (e.g., bash -lc '…'): do nothing; let -c run
esac
EOF

chown lfs:lfs /home/lfs/.bash_profile

cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

chown lfs:lfs /home/lfs/.bashrc
# ln -fs /mnt/net/d/LFS /home/lfs/lfs
chown lfs:lfs /home/lfs/lfs

mkdir -p $LFS/sources
chown lfs:lfs $LFS/sources

echoL "Fixing ownership under /home/lfs ..."
chown -Rv lfs:lfs /home/lfs

}


tests() {
    bash   # Place holder and to check fixed enviornment.


}

main() {
	export LFS=/mnt/lfs
	umask 022
	echoL "Test Left"
	echoR "Test Right"
	bash   # take a look around. TBR
	clean_partition
    new_partition
    file_system
    mounting_system
    inital_dirs
    environment
    tests    # Perform tests 
}

# call_bash  Starts a pre-configured prompt.
lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.
