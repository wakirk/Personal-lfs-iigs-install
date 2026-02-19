#!/bin/bash
#
# CachyOS Installation Script
# Generated from CachyOS Calamares installer analysis
# Repository: https://github.com/CachyOS/cachyos-calamares
#
# User Configuration:
#   - Language: en_US.UTF-8
#   - Timezone: America/Chicago
#   - Keyboard: us
#   - Bootloader: Limine
#   - Desktop: KDE Plasma
#   - Hostname: cachyos-x86qemu
#   - Username: wakirk (William Kirkpatrick)
#

# libcrc32c (dependency for btrfs)
if ! lsmod | grep -q '^libcrc32c '; then
    sudo insmod /lib/modules/6.6.47-1-lts/kernel/lib/libcrc32c.ko
fi

# xor (dependency for btrfs)
if ! lsmod | grep -q '^xor '; then
    sudo insmod /lib/modules/6.6.47-1-lts/kernel/crypto/xor.ko
fi

# raid6_pq (dependency for btrfs)
if ! lsmod | grep -q '^raid6_pq '; then
    sudo insmod /lib/modules/6.6.47-1-lts/kernel/lib/raid6/raid6_pq.ko
fi

# btrfs
if ! lsmod | grep -q '^btrfs '; then
    sudo insmod /lib/modules/6.6.47-1-lts/kernel/fs/btrfs/btrfs.ko
fi

# fat
if ! lsmod | grep -q '^fat '; then
    sudo insmod /lib/modules/6.6.47-1-lts/kernel/fs/fat/fat.ko
fi

# vfat (depends on fat)
if ! lsmod | grep -q '^vfat '; then
    sudo insmod /lib/modules/6.6.47-1-lts/kernel/fs/fat/vfat.ko
fi
pacman -Sy --noconfirm arch-install-scripts

# ===== PHASE 1: PREPARATION =====

echo "Step 1: Prompting for password"
read -s -p "Enter password for user and root: " USER_PASSWORD
echo
read -s -p "Confirm password: " USER_PASSWORD_CONFIRM
echo

if [ "$USER_PASSWORD" != "$USER_PASSWORD_CONFIRM" ]; then
    echo "ERROR: Passwords do not match!"
    exit 1
fi

if [ ${#USER_PASSWORD} -lt 4 ]; then
    echo "ERROR: Password must be at least 4 characters!"
    exit 1
fi

echo "Step 2: Setting error handling (set -e, set -u, set -o pipefail)"
set -e
set -u
set -o pipefail

echo "Step 3: Verifying running as root"
if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: This script must be run as root!"
    exit 1
fi

echo "Step 4: Verifying internet connectivity"
if ! ping -c 1 archlinux.org > /dev/null 2>&1; then
    if ! ping -c 1 cachyos.org > /dev/null 2>&1; then
        echo "ERROR: No internet connection!"
        exit 1
    fi
fi
echo "Internet connectivity verified."

# ===== CONFIGURATION VARIABLES =====

echo "Step 5: Setting configuration variables"
TARGET_DISK="/dev/sda"
ROOT_MOUNT="/target"
BOOT_PARTITION="${TARGET_DISK}1"
ROOT_PARTITION="${TARGET_DISK}2"
HOSTNAME="cachyos-x86qemu"
USERNAME="wakirk"
USER_FULLNAME="William Kirkpatrick"
LOCALE="en_US.UTF-8"
TIMEZONE="America/Chicago"
KEYMAP="us"
BTRFS_OPTS="defaults,noatime,compress=zstd"
BOOT_OPTS="defaults,umask=0077"

# ===== PHASE 2: DISK PARTITIONING =====

echo "Step 6: Wiping ${TARGET_DISK} completely"
wipefs --all --force "${TARGET_DISK}"
dd if=/dev/zero of="${TARGET_DISK}" bs=1M count=10 status=progress

echo "Step 7: Creating GPT partition table on ${TARGET_DISK}"
sgdisk --zap-all "${TARGET_DISK}"
sgdisk --clear "${TARGET_DISK}"

echo "Step 8: Creating partition 1 - 4192 MiB FAT32 EFI System (type EF00)"
sgdisk --new=1:0:+4192M --typecode=1:EF00 --change-name=1:"EFI" "${TARGET_DISK}"

echo "Step 9: Creating partition 2 - remaining space Btrfs Linux filesystem (type 8300)"
sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:"ROOT" "${TARGET_DISK}"

echo "Step 10: Informing kernel of partition table changes"
partprobe "${TARGET_DISK}"
sleep 2

echo "Step 11: Formatting ${BOOT_PARTITION} as FAT32"
mkfs.fat -F32 -n EFI "${BOOT_PARTITION}"

echo "Step 12: Formatting ${ROOT_PARTITION} as Btrfs"
mkfs.btrfs -f -L ROOT "${ROOT_PARTITION}"

# ===== PHASE 3: BTRFS SUBVOLUMES =====
set -x

echo "Step 12.5: Creating temporary mount point for Btrfs"
mkdir -p "$ROOT_MOUNT"

echo "Step 13: Mounting ${ROOT_PARTITION} temporarily to create subvolumes"
mount "${ROOT_PARTITION}" "${ROOT_MOUNT}"
set +x

echo "Step 14: Creating Btrfs subvolume @"
btrfs subvolume create "${ROOT_MOUNT}/@"

echo "Step 15: Creating Btrfs subvolume @home"
btrfs subvolume create "${ROOT_MOUNT}/@home"

echo "Step 16: Creating Btrfs subvolume @root"
btrfs subvolume create "${ROOT_MOUNT}/@root"

echo "Step 17: Creating Btrfs subvolume @srv"
btrfs subvolume create "${ROOT_MOUNT}/@srv"

echo "Step 18: Creating Btrfs subvolume @cache"
btrfs subvolume create "${ROOT_MOUNT}/@cache"

echo "Step 19: Creating Btrfs subvolume @tmp"
btrfs subvolume create "${ROOT_MOUNT}/@tmp"

echo "Step 20: Creating Btrfs subvolume @log"
btrfs subvolume create "${ROOT_MOUNT}/@log"

echo "Step 21: Unmounting ${ROOT_PARTITION}"
umount "${ROOT_MOUNT}"

# ===== PHASE 4: MOUNT FILESYSTEMS =====

echo "Step 22: Mounting @ subvolume to ${ROOT_MOUNT}"
mount -o "subvol=/@,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}"

echo "Step 23: Creating mount point directories"
mkdir -p "${ROOT_MOUNT}/home"
mkdir -p "${ROOT_MOUNT}/root"
mkdir -p "${ROOT_MOUNT}/srv"
mkdir -p "${ROOT_MOUNT}/var/cache"
mkdir -p "${ROOT_MOUNT}/var/tmp"
mkdir -p "${ROOT_MOUNT}/var/log"
mkdir -p "${ROOT_MOUNT}/boot"

echo "Step 24: Mounting @home subvolume to ${ROOT_MOUNT}/home"
mount -o "subvol=/@home,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}/home"

echo "Step 25: Mounting @root subvolume to ${ROOT_MOUNT}/root"
mount -o "subvol=/@root,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}/root"

echo "Step 26: Mounting @srv subvolume to ${ROOT_MOUNT}/srv"
mount -o "subvol=/@srv,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}/srv"

echo "Step 27: Mounting @cache subvolume to ${ROOT_MOUNT}/var/cache"
mount -o "subvol=/@cache,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}/var/cache"

echo "Step 28: Mounting @tmp subvolume to ${ROOT_MOUNT}/var/tmp"
mount -o "subvol=/@tmp,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}/var/tmp"

echo "Step 29: Mounting @log subvolume to ${ROOT_MOUNT}/var/log"
mount -o "subvol=/@log,${BTRFS_OPTS}" "${ROOT_PARTITION}" "${ROOT_MOUNT}/var/log"

echo "Step 30: Mounting ${BOOT_PARTITION} to ${ROOT_MOUNT}/boot"
mount -o "${BOOT_OPTS}" "${BOOT_PARTITION}" "${ROOT_MOUNT}/boot"

# ===== PHASE 4.5: CONFIGURE CACHYOS REPOSITORIES ON HOST =====

echo "Step 30.1: Importing CachyOS GPG key"
pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key F3B607488DB35A47

echo "Step 30.2: Creating CachyOS mirrorlist files"
cat > /etc/pacman.d/cachyos-mirrorlist << 'EOF'
Server = https://mirror.cachyos.org/repo/$arch/$repo
Server = https://cdn-77.cachyos.org/repo/$arch/$repo
Server = https://cdn-78.cachyos.org/repo/$arch/$repo
EOF

cat > /etc/pacman.d/cachyos-v3-mirrorlist << 'EOF'
Server = https://mirror.cachyos.org/repo/$arch_v3/$repo
Server = https://cdn-77.cachyos.org/repo/$arch_v3/$repo
Server = https://cdn-78.cachyos.org/repo/$arch_v3/$repo
EOF

cat > /etc/pacman.d/cachyos-v4-mirrorlist << 'EOF'
Server = https://mirror.cachyos.org/repo/$arch_v4/$repo
Server = https://cdn-77.cachyos.org/repo/$arch_v4/$repo
Server = https://cdn-78.cachyos.org/repo/$arch_v4/$repo
EOF

echo "Step 30.3: Setting architecture to baseline x86-64"
ARCH_LEVEL="base"
echo "Using baseline x86-64 (no v3/v4/znver4 optimizations)"


echo "Step 30.4: Configuring CachyOS repositories for baseline"

cat >> /etc/pacman.conf << 'EOF'

# CachyOS repository (baseline x86-64)
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
EOF

echo "Step 30.5: Syncing package databases"
pacman -Sy

# ===== PHASE 5: BASE SYSTEM INSTALLATION =====

echo "Step 31: Creating required directories for pacman"
mkdir -p "${ROOT_MOUNT}/var/lib/pacman"
mkdir -p "${ROOT_MOUNT}/var/cache/pacman/pkg"
mkdir -p "${ROOT_MOUNT}/etc/pacman.d"
mkdir -p "${ROOT_MOUNT}/dev"
mkdir -p "${ROOT_MOUNT}/run"
mkdir -p "${ROOT_MOUNT}/proc"
mkdir -p "${ROOT_MOUNT}/sys"
mkdir -p "${ROOT_MOUNT}/tmp"

echo "Step 32: Setting permissions on temporary directories"
chmod 1777 "${ROOT_MOUNT}/tmp"
chmod 0555 "${ROOT_MOUNT}/proc"
chmod 0555 "${ROOT_MOUNT}/sys"

echo "Step 33: Initializing pacman keyring on host (if needed)"
pacman-key --init

echo "Step 34: Updating CachyOS keyring on host"
pacman -Sy --noconfirm --needed cachyos-keyring archlinux-keyring

echo "Step 35: Populating pacman keyring"
pacman-key --populate archlinux cachyos

echo "Step 36: Copying mirrorlists to target system"
cp /etc/pacman.d/mirrorlist "${ROOT_MOUNT}/etc/pacman.d/"
cp /etc/pacman.d/cachyos-mirrorlist "${ROOT_MOUNT}/etc/pacman.d/"
cp /etc/pacman.d/cachyos-v3-mirrorlist "${ROOT_MOUNT}/etc/pacman.d/"
cp /etc/pacman.d/cachyos-v4-mirrorlist "${ROOT_MOUNT}/etc/pacman.d/"

echo "Step 37: Copying pacman gnupg keys to target system"
cp -a /etc/pacman.d/gnupg "${ROOT_MOUNT}/etc/pacman.d/"

echo "Step 38: Copying architecture-specific pacman configuration to target"
cp /etc/pacman.conf "${ROOT_MOUNT}/etc/pacman.conf"

echo "Step 39: Copying resolv.conf for network access"
cp /etc/resolv.conf "${ROOT_MOUNT}/etc/resolv.conf"

echo "Step 39.5: Rating mirrors for fastest downloads"

# Install mirror rating tools (small download)
pacman -Sy --noconfirm --needed rate-mirrors cachyos-rate-mirrors

echo "Step 39.6: Rating CachyOS mirrors"
cachyos-rate-mirrors

echo "Step 39.7: Rating Arch Linux mirrors"
rate-mirrors --allow-root --protocol https arch | tee /etc/pacman.d/mirrorlist

echo "Mirror rating complete - using fastest mirrors"

echo "Step 40: Installing base packages using pacman --sysroot"
# Base packages from pacstrap.conf
BASE_PACKAGES=(
    base
    base-devel
    btrfs-progs
    cachyos-hooks
    cachyos-keyring
    cachyos-mirrorlist
    cachyos-v4-mirrorlist
    cachyos-v3-mirrorlist
    cachyos-rate-mirrors
    cachyos-settings
    cryptsetup
    device-mapper
    diffutils
    dosfstools
    e2fsprogs
    efibootmgr
    exfatprogs
    f2fs-tools
    inetutils
    iptables-nft
    jfsutils
    less
    linux-cachyos
    linux-cachyos-headers
    linux-cachyos-lts
    linux-cachyos-lts-headers
    linux-firmware
    logrotate
    lsb-release
    lvm2
    man-db
    man-pages
    mdadm
    chwd
    mkinitcpio
    netctl
    os-prober
    perl
    python
    s-nail
    sudo
    sysfsutils
    texinfo
    usbutils
    which
    xfsprogs
    plymouth
    cachyos-plymouth-bootanimation
)


#pacman --sysroot "${ROOT_MOUNT}" -Sy --noconfirm --needed "${BASE_PACKAGES[@]}"
pacstrap -K "${ROOT_MOUNT}" "${BASE_PACKAGES[@]}"

echo "Step 41: Installing Limine bootloader packages"
LIMINE_PACKAGES=(
    limine
    limine-entry-tool
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${LIMINE_PACKAGES[@]}"

echo "Step 42: Installing Btrfs support packages for Limine"
BTRFS_LIMINE_PACKAGES=(
    snapper
    btrfs-assistant
    limine-snapper-sync
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${BTRFS_LIMINE_PACKAGES[@]}"

echo "Step 43: Installing CachyOS packages"
CACHYOS_PACKAGES=(
    cachyos-hello
    cachyos-kernel-manager
    cachyos-packageinstaller
    cachyos-micro-settings
    cachyos-wallpapers
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${CACHYOS_PACKAGES[@]}"

echo "Step 44: Installing CachyOS shell configuration"
SHELL_PACKAGES=(
    cachyos-fish-config
    cachyos-zsh-config
    fish
    zsh
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${SHELL_PACKAGES[@]}"

echo "Step 45: Installing Base-devel and common packages - Network"
NETWORK_PACKAGES=(
    dnsmasq
    dnsutils
    ethtool
    iwd
    modemmanager
    networkmanager
    networkmanager-openvpn
    nss-mdns
    usb_modeswitch
    wpa_supplicant
    wireless-regdb
    xl2tpd
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${NETWORK_PACKAGES[@]}"

echo "Step 46: Installing Base-devel and common packages - Firewall"
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed ufw

echo "Step 47: Installing Base-devel and common packages - Bluetooth"
BLUETOOTH_PACKAGES=(
    bluez
    bluez-hid2hci
    bluez-libs
    bluez-utils
    bluez-obex
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${BLUETOOTH_PACKAGES[@]}"

echo "Step 48: Installing Base-devel and common packages - Package management"
PKGMGMT_PACKAGES=(
    pacman-contrib
    pkgfile
    rebuild-detector
    reflector
    paru
    octopi
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${PKGMGMT_PACKAGES[@]}"

echo "Step 49: Installing Base-devel and common packages - Desktop integration"
DESKTOP_INTEGRATION_PACKAGES=(
    accountsservice
    bash-completion
    ffmpegthumbnailer
    gst-libav
    gst-plugin-pipewire
    gst-plugins-bad
    gst-plugins-ugly
    libdvdcss
    libgsf
    libopenraw
    plocate
    poppler-glib
    xdg-user-dirs
    xdg-utils
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${DESKTOP_INTEGRATION_PACKAGES[@]}"

echo "Step 50: Installing Base-devel and common packages - Filesystem"
FILESYSTEM_PACKAGES=(
    efitools
    nfs-utils
    nilfs-utils
    smartmontools
    unrar
    unzip
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${FILESYSTEM_PACKAGES[@]}"

echo "Step 51: Installing Base-devel and common packages - Fonts"
FONT_PACKAGES=(
    awesome-terminal-fonts
    noto-fonts-emoji
    cantarell-fonts
    noto-fonts
    ttf-bitstream-vera
    ttf-dejavu
    ttf-liberation
    ttf-opensans
    ttf-meslo-nerd
    noto-fonts-cjk
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${FONT_PACKAGES[@]}"

echo "Step 52: Installing Base-devel and common packages - Audio"
AUDIO_PACKAGES=(
    alsa-firmware
    alsa-plugins
    alsa-utils
    pavucontrol
    pipewire-pulse
    wireplumber
    pipewire-alsa
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${AUDIO_PACKAGES[@]}"

echo "Step 53: Installing Base-devel and common packages - Hardware"
HARDWARE_PACKAGES=(
    dmidecode
    dmraid
    hdparm
    hwdetect
    lsscsi
    mesa-utils
    mtools
    sg3_utils
    sof-firmware
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${HARDWARE_PACKAGES[@]}"

echo "Step 54: Installing Base-devel and common packages - Power"
POWER_PACKAGES=(
    cpupower
    power-profiles-daemon
    upower
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${POWER_PACKAGES[@]}"

echo "Step 55: Installing Base-devel and common packages - Applications"
APP_PACKAGES=(
    alacritty
    btop
    duf
    fsarchiver
    git
    glances
    hwinfo
    meld
    nano-syntax-highlighting
    fastfetch
    pv
    python-defusedxml
    python-packaging
    rsync
    wget
    ripgrep
    micro
    nano
    vim
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${APP_PACKAGES[@]}"

echo "Step 56: Installing KDE Plasma Desktop"
KDE_PACKAGES=(
    ark
    bluedevil
    breeze-gtk
    cachyos-emerald-kde-theme-git
    cachyos-iridescent-kde
    cachyos-kde-settings
    cachyos-nord-kde-theme-git
    cachyos-themes-sddm
    char-white
    dolphin
    egl-wayland
    ffmpegthumbs
    filelight
    fwupd
    gwenview
    haruna
    kate
    kcalc
    kde-gtk-config
    kdeconnect
    kdegraphics-thumbnailers
    kdeplasma-addons
    kdialog
    kinfocenter
    kio-admin
    konsole
    kscreen
    kwallet-pam
    kwalletmanager
    partitionmanager
    phonon-qt6-vlc
    plasma-browser-integration
    plasma-desktop
    plasma-firewall
    plasma-nm
    plasma-pa
    plasma-systemmonitor
    plasma-thunderbolt
    plymouth-kcm
    powerdevil
    plasma-login-manager
    spectacle
    xsettingsd
    sddm
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${KDE_PACKAGES[@]}"

echo "Step 57: Installing CPU microcode packages"
MICROCODE_PACKAGES=(
    amd-ucode
    intel-ucode
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${MICROCODE_PACKAGES[@]}"

echo "Step 58: Installing Firefox browser"
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed firefox

echo "Step 59: Installing printing support (CUPS)"
CUPS_PACKAGES=(
    cups
    cups-filters
    cups-pdf
    foomatic-db
    foomatic-db-engine
    foomatic-db-gutenprint-ppds
    foomatic-db-nonfree
    foomatic-db-nonfree-ppds
    foomatic-db-ppds
    ghostscript
    gsfonts
    gutenprint
    splix
    system-config-printer
)
pacman --sysroot "${ROOT_MOUNT}" -S --noconfirm --needed "${CUPS_PACKAGES[@]}"

# ===== PHASE 6: SYSTEM CONFIGURATION =====

echo "Step 60: Generating machine-id"
systemd-machine-id-setup --root="${ROOT_MOUNT}"

echo "Step 61: Generating fstab"
# Get UUIDs
ROOT_UUID=$(blkid -s UUID -o value "${ROOT_PARTITION}")
BOOT_UUID=$(blkid -s UUID -o value "${BOOT_PARTITION}")

cat > "${ROOT_MOUNT}/etc/fstab" << EOF
# /etc/fstab - Static file system information
# <device>                                 <mount>      <type>  <options>                              <dump> <pass>

# ${ROOT_PARTITION} - Btrfs root
UUID=${ROOT_UUID}  /            btrfs   subvol=/@,${BTRFS_OPTS}       0  0
UUID=${ROOT_UUID}  /home        btrfs   subvol=/@home,${BTRFS_OPTS}   0  0
UUID=${ROOT_UUID}  /root        btrfs   subvol=/@root,${BTRFS_OPTS}   0  0
UUID=${ROOT_UUID}  /srv         btrfs   subvol=/@srv,${BTRFS_OPTS}    0  0
UUID=${ROOT_UUID}  /var/cache   btrfs   subvol=/@cache,${BTRFS_OPTS}  0  0
UUID=${ROOT_UUID}  /var/tmp     btrfs   subvol=/@tmp,${BTRFS_OPTS}    0  0
UUID=${ROOT_UUID}  /var/log     btrfs   subvol=/@log,${BTRFS_OPTS}    0  0

# ${BOOT_PARTITION} - EFI/Boot partition
UUID=${BOOT_UUID}  /boot        vfat    ${BOOT_OPTS}                  0  2
EOF

echo "Step 62: Configuring locale - enabling ${LOCALE} in locale.gen"
sed -i "s/^#${LOCALE}/${LOCALE}/" "${ROOT_MOUNT}/etc/locale.gen"

echo "Step 63: Generating locales"
arch-chroot "${ROOT_MOUNT}" locale-gen

echo "Step 64: Writing /etc/locale.conf"
cat > "${ROOT_MOUNT}/etc/locale.conf" << EOF
LANG=${LOCALE}
LC_NUMERIC=${LOCALE}
LC_TIME=${LOCALE}
LC_MONETARY=${LOCALE}
LC_PAPER=${LOCALE}
LC_NAME=${LOCALE}
LC_ADDRESS=${LOCALE}
LC_TELEPHONE=${LOCALE}
LC_MEASUREMENT=${LOCALE}
LC_IDENTIFICATION=${LOCALE}
EOF

echo "Step 65: Setting timezone to ${TIMEZONE}"
arch-chroot "${ROOT_MOUNT}" ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime

echo "Step 66: Syncing hardware clock"
arch-chroot "${ROOT_MOUNT}" hwclock --systohc --utc

echo "Step 67: Configuring keyboard - console keymap"
echo "KEYMAP=${KEYMAP}" > "${ROOT_MOUNT}/etc/vconsole.conf"

echo "Step 68: Configuring keyboard - X11 configuration"
mkdir -p "${ROOT_MOUNT}/etc/X11/xorg.conf.d"
cat > "${ROOT_MOUNT}/etc/X11/xorg.conf.d/00-keyboard.conf" << EOF
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "${KEYMAP}"
    Option "XkbModel" "pc105"
EndSection
EOF

echo "Step 69: Setting hostname to ${HOSTNAME}"
echo "${HOSTNAME}" > "${ROOT_MOUNT}/etc/hostname"

echo "Step 70: Configuring /etc/hosts"
cat > "${ROOT_MOUNT}/etc/hosts" << EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   ${HOSTNAME}.localdomain ${HOSTNAME}
EOF

echo "Step 71: Configuring mkinitcpio.conf with systemd hooks"
cat > "${ROOT_MOUNT}/etc/mkinitcpio.conf" << EOF
# /etc/mkinitcpio.conf - CachyOS Configuration

MODULES=()

BINARIES=()

FILES=()

HOOKS=(base systemd autodetect microcode kms modconf block keyboard sd-vconsole plymouth filesystems)

COMPRESSION="zstd"
COMPRESSION_OPTIONS=(-19)
EOF

echo "Step 72: Generating initramfs"
arch-chroot "${ROOT_MOUNT}" mkinitcpio -P

echo "Step 72.5: Setting Plymouth boot animation theme"
arch-chroot "${ROOT_MOUNT}" plymouth-set-default-theme cachyos-bootanimation

echo "Step 73: Creating user ${USERNAME} (${USER_FULLNAME})"
arch-chroot "${ROOT_MOUNT}" useradd -m -G wheel,rfkill,sys,users,lp,video,network,storage,audio -c "${USER_FULLNAME}" -s /bin/bash "${USERNAME}"

echo "Step 74: Setting password for user ${USERNAME}"
echo "${USERNAME}:${USER_PASSWORD}" | arch-chroot "${ROOT_MOUNT}" chpasswd

echo "Step 75: Setting password for root (same as user)"
echo "root:${USER_PASSWORD}" | arch-chroot "${ROOT_MOUNT}" chpasswd

echo "Step 76: Setting home directory permissions"
chmod 700 "${ROOT_MOUNT}/home/${USERNAME}"

echo "Step 77: Enabling sudo for wheel group"
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' "${ROOT_MOUNT}/etc/sudoers"

# ===== PHASE 7: BOOTLOADER INSTALLATION =====

echo "Step 78: Installing Limine bootloader to EFI System Partition"
#arch-chroot "${ROOT_MOUNT}" limine bios-install "${TARGET_DISK}"
arch-chroot "${ROOT_MOUNT}" limine-install

echo "Step 79: Copying Limine EFI files to boot partition"
mkdir -p "${ROOT_MOUNT}/boot/EFI/BOOT"
cp "${ROOT_MOUNT}/usr/share/limine/BOOTX64.EFI" "${ROOT_MOUNT}/boot/EFI/BOOT/"

# works:
#echo "Step 80: Creating Limine configuration"
#cat > "${ROOT_MOUNT}/boot/limine.conf" << EOF
#timeout: 5
#default_entry: 1
#interface_resolution: 1024x768
#graphics: yes
#
#/CachyOS
#    protocol: linux
#    kernel_path: boot():/vmlinuz-linux-cachyos
#    kernel_cmdline: root=UUID=${ROOT_UUID} rootflags=subvol=/@ rw quiet nowatchdog
#    module_path: boot():/initramfs-linux-cachyos.img
#
#/CachyOS (LTS)
#    protocol: linux
#    kernel_path: boot():/vmlinuz-linux-cachyos-lts
#    kernel_cmdline: root=UUID=${ROOT_UUID} rootflags=subvol=/@ rw quiet nowatchdog
#    module_path: boot():/initramfs-linux-cachyos-lts.img
#
#/CachyOS (fallback)
#    protocol: linux
#    kernel_path: boot():/vmlinuz-linux-cachyos
#    kernel_cmdline: root=UUID=${ROOT_UUID} rootflags=subvol=/@ rw quiet nowatchdog
#    module_path: boot():/initramfs-linux-cachyos-fallback.img
#
#/CachyOS LTS (fallback)
#    protocol: linux
#    kernel_path: boot():/vmlinuz-linux-cachyos-lts
#    kernel_cmdline: root=UUID=${ROOT_UUID} rootflags=subvol=/@ rw quiet nowatchdog
#    module_path: boot():/initramfs-linux-cachyos-lts-fallback.img
#EOF
#
##--
#
#echo "Step 80.5: Configuring Limine theme colors and wallpaper"
#
## Copy the Limine splash image to boot partition
#cp "${ROOT_MOUNT}/usr/share/wallpapers/cachyos-wallpapers/limine-splash.png" "${ROOT_MOUNT}/boot/"
#
## Add color palette and wallpaper to limine.conf
#cat >> "${ROOT_MOUNT}/boot/limine.conf" << 'EOF'
#
## Catppuccin Mocha color palette
#term_palette: 0x45475a
#term_palette: 0xf38ba8
#term_palette: 0xa6e3a1
#term_palette: 0xf9e2af
#term_palette: 0x89b4fa
#term_palette: 0xf5c2e7
#term_palette: 0x94e2d5
#term_palette: 0xbac2de
#term_palette_bright: 0x585b70
#term_palette_bright: 0xf38ba8
#term_palette_bright: 0xa6e3a1
#term_palette_bright: 0xf9e2af
#term_palette_bright: 0x89b4fa
#term_palette_bright: 0xf5c2e7
#term_palette_bright: 0x94e2d5
#term_palette_bright: 0xa6adc8
#term_background: 0x1e1e2e
#term_foreground: 0xcdd6f4
#term_background_bright: 0x181825
#term_foreground_bright: 0xcdd6f4
#
## Wallpaper
#wallpaper: boot():/limine-splash.png
#EOF
#
##--

echo "Step 80: Copying Limine splash image"
cp "${ROOT_MOUNT}/usr/share/wallpapers/cachyos-wallpapers/limine-splash.png" "${ROOT_MOUNT}/boot/"

echo "Step 80.1: Creating Limine configuration with theme"
cat > "${ROOT_MOUNT}/boot/limine.conf" << 'EOF'
timeout: 5
default_entry: 2
remember_last_entry: yes
interface_resolution: 1024x768
graphics: yes

# CachyOS Limine theme (matches cachyos-calamares)
# Author: diegons490 (https://github.com/diegons490/cachyos-limine-theme)
term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_background: ffffffff
term_foreground: cdd6f4
term_background_bright: ffffffff
term_foreground_bright: cdd6f4

# Catppuccin Mocha theme
# term_palette: 0x45475a
# term_palette: 0xf38ba8
# term_palette: 0xa6e3a1
# term_palette: 0xf9e2af
# term_palette: 0x89b4fa
# term_palette: 0xf5c2e7
# term_palette: 0x94e2d5
# term_palette: 0xbac2de
# term_palette_bright: 0x585b70
# term_palette_bright: 0xf38ba8
# term_palette_bright: 0xa6e3a1
# term_palette_bright: 0xf9e2af
# term_palette_bright: 0x89b4fa
# term_palette_bright: 0xf5c2e7
# term_palette_bright: 0x94e2d5
# term_palette_bright: 0xa6adc8
# term_background: 0x1e1e2e
# term_foreground: 0xcdd6f4
# term_background_bright: 0x181825
# term_foreground_bright: 0xcdd6f4

# Fix for blacked out work area and text
editor_background: 0x1e1e2e
editor_foreground: 0xcdd6f4
editor_highlight: 0x89b4fa
editor_highlight_foreground: 0x1e1e2e

interface_branding: CachyOS

wallpaper: boot():/limine-splash.png

/+CachyOS
EOF

echo "Step 81: Configuring EFI boot entry using efibootmgr"
arch-chroot "${ROOT_MOUNT}" efibootmgr --create --disk "${TARGET_DISK}" --part 1 --label "CachyOS" --loader "\\EFI\\BOOT\\BOOTX64.EFI"

echo "Step 82: Configuring Limine snapper sync for Btrfs snapshots"
if [ -f "${ROOT_MOUNT}/etc/limine-snapper-sync.conf" ]; then
    sed -i 's/TARGET_OS_NAME=".*"/TARGET_OS_NAME="CachyOS"/' "${ROOT_MOUNT}/etc/limine-snapper-sync.conf"
    arch-chroot "${ROOT_MOUNT}" pacman -S --noconfirm --needed cachyos-snapper-support
    arch-chroot "${ROOT_MOUNT}" systemctl enable limine-snapper-sync.service
fi

echo "Step 82.5: Creating /etc/default/limine configuration"

# Get the root partition UUID
ROOT_UUID=$(blkid -s UUID -o value "${ROOT_PARTITION}")

mkdir -p "${ROOT_MOUNT}/etc/default"
cat > "${ROOT_MOUNT}/etc/default/limine" << EOF
ESP_PATH="/boot"
KERNEL_CMDLINE[default]+="quiet splash rw root=UUID=${ROOT_UUID} rootflags=subvol=/@"
BOOT_ORDER="*, *lts, *fallback, Snapshots"
EOF

#echo "Step 82.5: Creating /etc/default/limine configuration"
#
## Get the root partition UUID
#ROOT_UUID=$(blkid -s UUID -o value "${ROOT_PARTITION}")
#
#mkdir -p "${ROOT_MOUNT}/etc/default"
#
##cat > "${ROOT_MOUNT}/etc/default/limine" << EOF
##ESP_PATH="/boot"
##KERNEL_CMDLINE[default]+="root=UUID=${ROOT_UUID} rootflags=subvol=/@ rw quiet nowatchdog"
##BOOT_ORDER="*, *lts, *fallback, Snapshots"
##EOF

cat > "${ROOT_MOUNT}/etc/default/limine" << EOF
ESP_PATH="/boot"
KERNEL_CMDLINE[default]+="root=UUID=${ROOT_UUID} rootflags=subvol=/@ rw quiet nowatchdog splash"
BOOT_ORDER="*, *lts, *fallback, Snapshots"
EOF

echo "Created /etc/default/limine with kernel command line"

echo "Step 83: Replacing limine-entry-tool with limine-mkinitcpio-hook"
arch-chroot "${ROOT_MOUNT}" pacman -R --noconfirm limine-entry-tool
arch-chroot "${ROOT_MOUNT}" pacman -S --noconfirm --needed limine-mkinitcpio-hook

echo "Step 84: Adding sd-btrfs-overlayfs hook for snapshot support"
if [ -f "${ROOT_MOUNT}/etc/limine-snapper-sync.conf" ]; then
    mkdir -p "${ROOT_MOUNT}/etc/mkinitcpio.conf.d"
    cat > "${ROOT_MOUNT}/etc/mkinitcpio.conf.d/10-limine-snapper-sync.conf" << EOF
# This hook is necessary for the proper loading of Limine snapshots.
# Please do not touch unless you know what you are doing.
HOOKS+=(sd-btrfs-overlayfs)
EOF
fi

echo "Step 85: Running limine-update to finalize bootloader configuration"
arch-chroot "${ROOT_MOUNT}" limine-update

# ===== PHASE 8: SERVICES AND FINAL CONFIGURATION =====

echo "Step 86: Enabling NetworkManager service"
arch-chroot "${ROOT_MOUNT}" systemctl enable NetworkManager

echo "Step 87: Enabling cups (printing) service"
arch-chroot "${ROOT_MOUNT}" systemctl enable cups

echo "Step 88: Enabling avahi-daemon service"
arch-chroot "${ROOT_MOUNT}" systemctl enable avahi-daemon

echo "Step 89: Enabling systemd-timesyncd service"
arch-chroot "${ROOT_MOUNT}" systemctl enable systemd-timesyncd

echo "Step 90: Enabling fstrim.timer service"
arch-chroot "${ROOT_MOUNT}" systemctl enable fstrim.timer

echo "Step 91: Enabling bluetooth service"
arch-chroot "${ROOT_MOUNT}" systemctl enable bluetooth

echo "Step 92: Enabling SDDM display manager"
arch-chroot "${ROOT_MOUNT}" systemctl enable sddm

#echo "Step 93: Configuring UFW firewall - setting default policies"
#arch-chroot "${ROOT_MOUNT}" ufw default deny incoming
#arch-chroot "${ROOT_MOUNT}" ufw default allow outgoing

#echo "Step 94: Enabling UFW firewall"
#arch-chroot "${ROOT_MOUNT}" ufw enable

#echo "Step 95: Enabling UFW service"
#arch-chroot "${ROOT_MOUNT}" systemctl enable ufw

#--
echo "Step 93-95: Configuring UFW firewall (if installed)"
if arch-chroot "${ROOT_MOUNT}" pacman -Qs ufw > /dev/null 2>&1; then
    # Just configure policies - DON'T enable yet
    arch-chroot "${ROOT_MOUNT}" ufw default deny incoming
    arch-chroot "${ROOT_MOUNT}" ufw default allow outgoing
    # Only enable the systemd service (starts on first boot, not in chroot)
    arch-chroot "${ROOT_MOUNT}" systemctl enable ufw
    # Skip "ufw enable" - it will auto-activate on first boot
fi

#--

echo "Step 96: Removing wrong microcode package based on CPU vendor"
CPU_VENDOR=$(grep -m1 "vendor_id" /proc/cpuinfo | awk '{print $3}')
case "${CPU_VENDOR}" in
    GenuineIntel)
        if arch-chroot "${ROOT_MOUNT}" pacman -Q amd-ucode > /dev/null 2>&1; then
            arch-chroot "${ROOT_MOUNT}" pacman -R --noconfirm amd-ucode
        fi
        ;;
    AuthenticAMD|*)
        if arch-chroot "${ROOT_MOUNT}" pacman -Q intel-ucode > /dev/null 2>&1; then
            arch-chroot "${ROOT_MOUNT}" pacman -R --noconfirm intel-ucode
        fi
        ;;
esac

echo "Step 97: Setting up user shell (fish or zsh if available)"
if [ -e "${ROOT_MOUNT}/bin/fish" ]; then
    arch-chroot "${ROOT_MOUNT}" chsh -s /bin/fish "${USERNAME}"
elif [ -e "${ROOT_MOUNT}/bin/zsh" ]; then
    arch-chroot "${ROOT_MOUNT}" chsh -s /bin/zsh "${USERNAME}"
fi

echo "Step 98: Copying skeleton files to user home"
arch-chroot "${ROOT_MOUNT}" runuser -u "${USERNAME}" -- cp -rf /etc/skel/. "/home/${USERNAME}/"

echo "Step 99: Removing X session files from user home"
arch-chroot "${ROOT_MOUNT}" runuser -u "${USERNAME}" -- rm -rf "/home/${USERNAME}/.xsession" "/home/${USERNAME}/.xprofile" "/home/${USERNAME}/.xinitrc"

#echo "Step 100: Creating xdg user directories"
#arch-chroot "${ROOT_MOUNT}" runuser -u "${USERNAME}" -- xdg-user-dirs-update
#echo "Step 100 skipped."
echo "Step 100: Copying custom files to OS."
cp /root/lfs/config/link-qemu.sh /target/home/wakirk 

# ===== PHASE 9: CLEANUP =====

echo "Step 101: Syncing filesystem"
sync

echo "Step 102: Unmounting /mnt/boot"
umount "${ROOT_MOUNT}/boot"

echo "Step 103: Unmounting /mnt/var/log"
umount "${ROOT_MOUNT}/var/log"

echo "Step 104: Unmounting /mnt/var/tmp"
umount "${ROOT_MOUNT}/var/tmp"

echo "Step 105: Unmounting /mnt/var/cache"
umount "${ROOT_MOUNT}/var/cache"

echo "Step 106: Unmounting /mnt/srv"
umount "${ROOT_MOUNT}/srv"

echo "Step 107: Unmounting /mnt/root"
umount "${ROOT_MOUNT}/root"

echo "Step 108: Unmounting /mnt/home"
umount "${ROOT_MOUNT}/home"

echo "Step 109: Unmounting /mnt (root filesystem)"
umount "${ROOT_MOUNT}"

echo "Step 110: Installation complete!"
echo ""
echo "=========================================="
echo "  CachyOS Installation Complete!"
echo "=========================================="
echo ""
echo "System Details:"
echo "  - Hostname: ${HOSTNAME}"
echo "  - Username: ${USERNAME} (${USER_FULLNAME})"
echo "  - Desktop: KDE Plasma"
echo "  - Bootloader: Limine"
echo "  - Filesystem: Btrfs with subvolumes"
echo "  - Locale: ${LOCALE}"
echo "  - Timezone: ${TIMEZONE}"
echo ""
echo "You can now reboot into your new CachyOS system."
echo "Run: reboot"
echo ""
