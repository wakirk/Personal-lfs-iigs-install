#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

 main () {

	# Linux (6.16.1) - 149,042 KB:
	# Home page: https://www.kernel.org/
	# Download: https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz
	# MD5 sum: 32d45755e4b39d06e9be58f6817445ee
	echoR "Kernel Software"

	echoL "Downloading Linux (6.16.1)..."
	sleep 2
	cd "/root/lfs/1.06-Install-System-Software"
	../bash/Download.sh https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz linux-6.16.1.tar.xz
	cp ../Packages/linux-6.16.1.tar.xz /sources

	echoL "Unpack Linux (6.16.1)..."
	sleep 2
	cd /sources
	rm -fR linux-6.16.1
	tar -vxsf linux-6.16.1.tar.xz
	cd linux-6.16.1

	echoL "Building Linux (6.16.1)..."
	sleep 2
	make mrproper
	make allnoconfig	# everything = n
	cat > Kernel.cfg << "EOF"

# ==== Arch / base ====

# BLFS UEFI boot essentials (built-in)

# Processor type and features → EFI runtime + stub
CONFIG_EFI=y
CONFIG_EFI_STUB=y

# Block layer + GPT
CONFIG_BLOCK=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_EFI_PARTITION=y

# Filesystems → FAT/VFAT + NLS + efivarfs
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_EFIVAR_FS=y

# (Optional but often handy since BLFS mentions EXFAT)
CONFIG_EXFAT_FS=y


# Parents that reveal the missing menus
CONFIG_INPUT=y

CONFIG_USB_SUPPORT=y
CONFIG_USB=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y

CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_GENERIC=y

# Optional on PCs (ULPI = external USB PHY bus; usually not needed on x86)
CONFIG_USB_ULPI_BUS=y

CONFIG_USB_ULPI_BUS=y
CONFIG_HID_SUPPORT=y

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_ACPI=y

# Monolithic kernel
# CONFIG_MODULES is not set
CONFIG_FW_LOADER=y
# CONFIG_FW_LOADER_USER_HELPER is not set

# Core pseudo filesystems
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y

# ==== Buses / block path ====
CONFIG_PCI=y
CONFIG_PCI_MSI=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_EFI_PARTITION=y

# ==== Storage ====
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_CORE=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y

# ==== Filesystems ====
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y

# FAT / DOS
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"

# Exec formats & sockets
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_UNIX=y

# ==== UEFI / console / graphics ====
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFIVAR_FS=y

# Text console on framebuffer
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_TTY=y
CONFIG_FRAMEBUFFER_CONSOLE=y

# DRM/KMS + early console
CONFIG_DRM=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_SIMPLEDRM=y

# EFI/simple FB fallbacks
CONFIG_FB=y
CONFIG_FB_EFI=y
CONFIG_FB_SIMPLE=y

# GPUs
CONFIG_DRM_I915=y
CONFIG_DRM_NOUVEAU=y

# ==== USB / HID / Input ====
CONFIG_USB=y
CONFIG_USB_STORAGE=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y

CONFIG_INPUT=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_UINPUT=y
CONFIG_UHID=y

CONFIG_HID=y
CONFIG_HID_GENERIC=y
CONFIG_USB_HID=y
CONFIG_HID_SONY=y
CONFIG_HID_NINTENDO=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_HIDRAW=y

# PS/2 fallback
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_KEYBOARD_ATKBD=y

# ==== Networking ====
CONFIG_NET=y
CONFIG_NETDEVICES=y
CONFIG_ETHERNET=y
CONFIG_PACKET=y
CONFIG_INET=y
CONFIG_IPV6=y

# Wired NIC
CONFIG_R8169=y

# Wi-Fi stack + crypto
CONFIG_WLAN=y
CONFIG_CFG80211=y
CONFIG_MAC80211=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_MICHAEL_MIC=y

# Intel Wi-Fi driver
CONFIG_IWLWIFI=y
CONFIG_IWLMVM=y

# Bluetooth (+ HID over BT, USB transport)
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_LE=y
CONFIG_BT_HIDP=y
CONFIG_BT_HCIBTUSB=y

# ==== Audio ====
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_PCI=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_GENERIC=y

# ==== Platform / sensors / RTC ====
CONFIG_I2C=y
CONFIG_I2C_I801=y
CONFIG_EEPROM=y
CONFIG_EE1004=y

CONFIG_SPI=y
CONFIG_SPI_NOR=y
CONFIG_MTD=y
CONFIG_MTD_SPI_NOR=y
CONFIG_SPI_INTEL_PCI=y

CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_PCH_THERMAL=y

CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_WATCHDOG=y
CONFIG_ITCO_WDT=y

CONFIG_HWMON=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_NVME_HWMON=y

CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_DRV_CMOS=y

# ==== CPU / scheduler / timers ====
CONFIG_SMP=y
CONFIG_NR_CPUS=16
CONFIG_SCHED_MC=y
CONFIG_SCHED_SMT=y

# Low-latency profile
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

# Tick / HZ
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_HZ_1000=y

# Power mgmt
CONFIG_CPU_FREQ=y
CONFIG_X86_INTEL_PSTATE=y
CONFIG_INTEL_IDLE=y

# ==== Memory ====
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y

# === cgroups is required by LFS =====
CONFIG_CGROUPS=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_CPUSETS=y
CONFIG_CGROUP_PIDS=y
CONFIG_MEMCG=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_BPF=y

# === QEMU Client setup
CONFIG_KVM=y
# on Intel
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD=y      # on AMD (use this instead of INTEL)

# tap devices (/dev/net/tun)
CONFIG_TUN=y
# linux bridge
CONFIG_BRIDGE=y
CONFIG_VETH=y
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y

# nftables NAT (preferred modern stack)
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REDIR=y
CONFIG_NFT_NAT=y
CONFIG_NFT_MASQ=y

CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST_SCSI=y
CONFIG_VHOST_VDPA=y

CONFIG_VFIO=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_VIRQFD=y

CONFIG_IOMMU_SUPPORT=y
# Intel VT-d
CONFIG_INTEL_IOMMU=y
# CONFIG_AMD_IOMMU=y           # AMD-Vi (use on AMD)
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y

CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_KSM=y

CONFIG_BLK_DEV_LOOP=y
# for qemu-nbd
CONFIG_BLK_DEV_NBD=y

CONFIG_PARTITION_ADVANCED=y
CONFIG_EFI_PARTITION=y

CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BLK=y
CONFIG_SCSI=y
# if you use virtio-scsi instead of virtio-blk
CONFIG_SCSI_VIRTIO=y
CONFIG_BLK_DEV_SD=y

CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_PIIX=y  

CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y

CONFIG_USB_STORAGE=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_UAS=y

CONFIG_EXT4_FS=y
CONFIG_VFAT_FS=y
CONFIG_EXFAT_FS=y
CONFIG_NTFS3_FS=y

# NTFS3 POSIX Access Control Lists
CONFIG_NTFS3_FS_POSIX_ACL=y
# NTFS3 LZX/Xpress compression 
CONFIG_NTFS3_LZX_XPRESS=y

CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_UNIX=y
CONFIG_NLS_UTF8=y

# File systems → Inotify support for userspace
CONFIG_INOTIFY_USER=y
# Device Drivers → Generic Driver Options
CONFIG_DEVTMPFS=y
# (auto-mount /dev at boot)
CONFIG_DEVTMPFS_MOUNT=y

CONFIG_SWAP=y

# File systems --->
CONFIG_FUSE_FS=y
# FUSE (Filesystem in Userspace) support
CONFIG_FUSE_FS=y
#  Character device in Userspace support
CONFIG_CUSE=y

CONFIG_NTSYNC=y

  # Device Drivers → Graphics support:
  CONFIG_DRM=y
  CONFIG_DRM_KMS_HELPER=y
  # early console from EFI GOP
  CONFIG_DRM_SIMPLEDRM=y
  # for your -device virtio-vga
  CONFIG_DRM_VIRTIO_GPU=y

  # Device Drivers → Graphics support → Console display driver support:
  CONFIG_FRAMEBUFFER_CONSOLE=y
  # optional
  CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y

  # Device Drivers → Character devices:
  CONFIG_VT=y
  CONFIG_VT_CONSOLE=y
  CONFIG_HW_CONSOLE=y


EOF
	# merge ONLY your required bits (the fragments we made earlier)
	echo "patching setup..."
	scripts/kconfig/merge_config.sh .config Kernel.cfg > output.txt 2>&1
	cp output.txt /root/lfs/bash
	echo "done."
	make olddefconfig 
	# 1) Confirm the parents really are ON in your final .config
	for k in CONFIG_USB CONFIG_USB_XHCI_HCD CONFIG_USB_XHCI_PCI \
		CONFIG_INPUT CONFIG_HID CONFIG_USB_HID CONFIG_HID_GENERIC \
		CONFIG_BT CONFIG_BT_HIDP ; do
		scripts/config --state "$k"
	done
	# 2) Make sure your fragment has NO lines that turn these off later.
	# (Order matters in fragments: last assignment wins.)
	grep -nE '^(# +CONFIG_(USB(|_XHCI_HCD|_XHCI_PCI)|HID(|_GENERIC|_SONY|_NINTENDO)|USB_HID|INPUT|UHID|UINPUT|JOYSTICK_XPAD|BT(|_HIDP)) +is +not +set)' Kernel.cfg

	echoL "Configure Linux Kernerl Setup (6.16.1)"
#	make nconfig
	cp .config /root/lfs/bash/config.default
#	/bin/bash
#	return 1

	echoL "Building Linux (6.16.1)..."
	make

	echoL "Installing Linux (6.16.1)..."
	sleep 2
	cp -fv arch/x86/boot/bzImage /boot/vmlinuz-6.16.1-lfs-12.4
	cp -fv System.map /boot/System.map-6.16.1
	cp -fv .config /boot/config-6.16.1
	cp -frv Documentation -T /usr/share/doc/linux-6.16.1
# 	install -v -m755 -d /etc/modprobe.d

	echoL "Cleaning up build area...."
	sleep 8
	cd /sources
	rm -fR linux-6.16.1

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
