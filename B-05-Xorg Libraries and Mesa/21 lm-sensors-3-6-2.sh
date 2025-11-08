#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	#	Which-2.23

	# Optional
	#	RRDtool (required to build the sensord program) and dmidecode (runtime)

# Kernel Configuration
# The following configuration options attempt to cover the most common hardware monitoring devices
# in a typical desktop or laptop system. View the help of each (by pressing the H button with the option
# focused in the make menuconfig) to know if you need it. There are many platform-specific
# hardware monitoring devices so it's impossible to list the configuration for all of them here.
# You may investigate the content of /sys/class/hwmon within a “mainstream” distro running on the
# system to know which drivers you need.

#Power management and ACPI options --->
#  [*] ACPI (Advanced Configuration and Power Interface) Support --->      [ACPI]
#    < /*/M> Battery                                               [ACPI_BATTERY]
#    < /*/M> Thermal Zone                                          [ACPI_THERMAL]

#Device Drivers --->
#  NVME Support --->
#    < /*> NVM Express block device                                [BLK_DEV_NVME]
#    # Set [HWMON] to <*> (not <M>!) or it will not show up:
#    [ /*] NVMe hardware monitoring                                  [NVME_HWMON]
#  <*/M> Hardware Monitoring support --->                                 [HWMON]
#    < /*/M> AMD Athlon64/FX or Opteron temperature sensor       [SENSORS_K8TEMP]
#    < /*/M> AMD Family 10h+ temperature sensor                 [SENSORS_K10TEMP]
#    < /*/M> AMD Family 15h processor power                [SENSORS_FAM15H_POWER]
#    < /*/M> Intel Core/Core2/Atom temperature sensor          [SENSORS_CORETEMP]

# Config File
# /etc/sensors3.conf

main () {

	# Download (HTTP): https://github.com/hramrach/lm-sensors/archive/V3-6-2/lm-sensors-3-6-2.tar.gz
	# Download MD5 sum: 44c733f509cd4a31494fd3e355152b0a
	# Download size: 288 KB
	# Estimated disk space required: 2.7 MB
	# Estimated build time: less than 0.1 SBU
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading lm-sensors (3.6.2)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://github.com/hramrach/lm-sensors/archive/V3-6-2/lm-sensors-3-6-2.tar.gz lm-sensors-3-6-2.tar.gz
	cp ../Packages/lm-sensors-3-6-2.tar.gz /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack lm-sensors (3.6.2)..."
	sleep 2
	cd /sources
	rm -fR lm-sensors-3-6-2
	tar -vxsf lm-sensors-3-6-2.tar.gz
	cd lm-sensors-3-6-2

	echoL "Building lm-sensors (3.6.2)..."
	sleep 2
	make PREFIX=/usr        \
		BUILD_STATIC_LIB=0  \
		PROG_EXTRA=sensord  \
		MANDIR=/usr/share/man
	read

	echoL "Installing lm-sensors (3.6.2)..."
	sleep 2
	make PREFIX=/usr       \
		BUILD_STATIC_LIB=0 \
		MANDIR=/usr/share/man install
	install -v -m755 -d /usr/share/doc/lm-sensors-3-6-2
	cp -rv README INSTALL doc/* /usr/share/doc/lm-sensors-3-6-2
	read

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR lm-sensors-3-6-2

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
