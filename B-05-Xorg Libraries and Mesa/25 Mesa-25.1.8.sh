#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

	# Required
	# Xorg Libraries
	# libdrm-2.4.125
	# Mako-1.3.10
	# PyYAML-6.0.2

	# Recommended
	#	Glslang-15.4.0 (required for Vulkan support)
	#	libva-2.22.0 (to provide VA-API support for some gallium drivers. 
	#		Note that there is a circular dependency. You must build libva first
	#			without mesa's EGL and GLX support, install this package, and rebuild libva)
	#	libvdpau-1.5 (to build VDPAU drivers)
	#	LLVM-20.1.8 (required for the llvmpipe, r300, r600, and radeonsi drivers)
	#	wayland-protocols-1.45 (required for Plasma-6.4.4, GNOME, and recommended for GTK-3.24.50)
	#	libclc-20.1.8 (required for the Intel iris gallium driver)
	#	Vulkan-Loader-1.4.321 (required for Vulkan support)
	#	ply-3.11 (required for the Intel vulkan driver)
	#	Cbindgen-0.29.0, make-ca-1.16.1, and rust-bindgen-0.72.0
	#		(required for the Nouveau Vulkan driver)

	# [Note] Note
	#	An Internet connection is needed for building the Nouveau Vulkan driver.
	#	The system certificate store may need to be set up with make-ca-1.16.1 before building this package.

	# [Note] Note
	#	Choosing Mesa Drivers
	#	In the instructions below, all the available drivers are built. That will almost always work.
	#	However, it is not efficient. Depending on your video hardware, you probably need only
	#	specific drivers.

	#	The first thing you need to know is which type of video device you have. In some
	#	cases it is built into the CPU. In others it is a separate PCI card. In either
	#	case you can tell what video hardware you have by installing pciutils-3.14.0 and running:

	#	The video device is most likely one of three families: AMD, Intel, or NVIDIA. See the Command
	#	Explanations for -D gallium-drivers=auto below to see what options are available for your
	#	specific video hardware (or emulated video hardware). You should probably add the softpipe
	#	or llvmpipe option as a backup driver.

	#	For 'platforms' you can select x11 and/or wayland. Note that in BLFS currently
	#	only Gnome and KDE can use wayland. If you are not going to use one of those
	#	desktop environments then you probably only want x11.

	#	For 'vulkan-drivers' you may want to limit the selection to your current hardware.
	#	These drivers are used by some specific applications. For example, ffmpeg
	#	(including ffplay) will use Vulkan instead of OpenGL for rendering video on the GPU.
	#	If you do not want to do this you may or may not want to install them. See the
	#	Command Explanations for -D vulkan-drivers=auto below to see what options
	#	are available for your specific video hardware (or emulated video hardware).
	#	You should probably add the swrast option as a backup driver unless you
	#	don't need Vulkan at all.

	# Optional
	#	libgcrypt-1.11.2
	#	libunwind-1.8.2
	#	lm-sensors-3-6-2
	#	Nettle-3.10.2
	#	Valgrind-3.25.1
	#	mesa-demos (provides more than 300 extra demos to test Mesa; this includes the same
	#		programs added by the patch above), 
	#	Bellagio OpenMAX Integration Layer (for mobile platforms)
	#	libtizonia,

# Kernel Configuration
# Enable the following options in the kernel configuration and recompile the kernel if necessary:

# Device Drivers --->
#   Graphics support --->
#     <*/M>   Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) --->
#                                                                       ...  [DRM]
#     # For r300 or r600:
#     < /*/M> ATI Radeon                                              [DRM_RADEON]
#     
#     # For radeonsi:
#     < /*/M> AMD GPU                                                 [DRM_AMDGPU]
#     [*]       Enable amdgpu support for SI parts                 [DRM_AMDGPU_SI]
#     [*]       Enable amdgpu support for CIK parts               [DRM_AMDGPU_CIK]
#       Display Engine Configuration --->
#       [*]   AMD DC - Enable new display engine                      [DRM_AMD_DC]
#     
#     
#     # For i915, crocus, or iris:
#     < /*/M> Intel 8xx/9xx/G3x/G4x/HD Graphics                         [DRM_I915]
#     
#     # For iris:
#     < /*/M> Intel Xe2 Graphics                                          [DRM_XE]
#     [*]       Enable display support                            [DRM_XE_DISPLAY]
#     (*)       Force probe xe for selected Intel hardware IDs
#                                                        ...  [DRM_XE_FORCE_PROBE]
#     
#     # For llvmpipe or softpipe:
#     < /*>   Virtual GEM provider                                      [DRM_VGEM]
#     
#     # For svga:
#     < /*/M> DRM driver for VMware Virtual GPU                       [DRM_VMWGFX]

# [Note] Note
#	The corresponding Mesa Gallium3D driver name is provided as the comment for the
#	configuration entries. If you don't know the name of the Mesa Gallium3D driver for
#	your GPU, see Mesa Gallium3D Drivers below.

#	For the GPUs supported by the Iris Gallium3D driver, with CONFIG_DRM_I915 enabled and
#	CONFIG_DRM_XE_FORCE_PROBE set to the string *, the i915 driver will be used if it supports
#	the GPU, and the Xe driver will be used if it supports the GPU but the i915 driver
#	does not. If you are sure your GPU is supported by the i915 driver, you can disable
#	the Xe driver to save some build time. If your GPU is supported by both drivers and
#	you want to use the Xe driver, you can disable the i915 driver, or make the i915 driver
#	deny your GPU via the CONFIG_DRM_I915_FORCE_PROBE option, for example setting it to !7d55
#	would make i915 deny the Meteor Lake integrated GPU (of which the PCI ID is 8086:7d55),
#	leaving it for the Xe driver.

#	CONFIG_DRM_RADEON, CONFIG_DRM_AMDGPU, CONFIG_DRM_NOUVEAU, CONFIG_DRM_I915,
#	and CONFIG_DRM_XE may require firmware. See About Firmware for details.

#	Selecting CONFIG_DRM_RADEON, CONFIG_DRM_AMDGPU, or CONFIG_DRM_NOUVEAU as “y” is not recommended.
#	If it is, any required firmware must be built as a part of the kernel image or the initramfs
#	for the driver to function correctly.

#	The sub-entries under CONFIG_DRM_AMDGPU are used to ensure the AMDGPU kernel driver supports
#	all GPUs using the radeonsi driver. They are not needed if you won't need CONFIG_DRM_AMDGPU
#	itself. They may be unneeded for some GPU models.

#	For llvmpipe or softpipe, CONFIG_DRM_VGEM is required or X clients may fail to start with
#	a cryptic message Error: couldn't get an RGB, Double-buffered visual. Strictly speaking, it
#	can be compiled as a module. But the module will not be loaded automatically, so it's 
#	more convenient to build it as a part of the kernel image.

main () {

	# lspci | grep VGA	results:
	# 00:02.0 VGA compatible controller [0300]:
	#	Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630] [8086:3e9b] (rev 02)
	# 01:00.0 VGA compatible controller [0300]:
	#	NVIDIA Corporation TU117M [GeForce GTX 1650 Mobile / Max-Q] [10de:1f91] (rev a1)

	# Package Information
	# Download (HTTP): https://mesa.freedesktop.org/archive/mesa-25.1.8.tar.xz
	# Download MD5 sum: fe3eb39e8a3c6fbb36eb3da57be022e7
	# Download size: 45 MB
	# Estimated disk space required: 1.1 GB (with docs; add 576 MB for tests)
	# Estimated build time: 3.8 SBU (with docs; add 1.7 SBU for tests; both with parallelism=4)

	#Additional Downloads
	#Recommended patch: https://www.linuxfromscratch.org/patches/blfs/12.4/mesa-add_xdemos-4.patch (installs 2 demo programs for testing Mesa - not needed if you install the mesa-demos package)
	echoR "Group 5 Xorg Libraries and Mesa"

	echoL "Downloading Mesa (25.1.8)..."
	sleep 2
	cd "/root/lfs/B-05-Xorg Libraries and Mesa"
	../bash/Download.sh https://mesa.freedesktop.org/archive/mesa-25.1.8.tar.xz mesa-25.1.8.tar.xz
	cp ../Packages/mesa-25.1.8.tar.xz /sources

	../bash/Download.sh https://www.linuxfromscratch.org/patches/blfs/12.4/mesa-add_xdemos-4.patch mesa-add_xdemos-4.patch
	cp ../Packages/mesa-add_xdemos-4.patch /sources

	export XORG_PREFIX="/usr"
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"

	echoL "Unpack Mesa (25.1.8)..."
	sleep 2
	cd /sources
	rm -fR mesa-25.1.8
	tar -vxsf mesa-25.1.8.tar.xz
	cd mesa-25.1.8

	echoL "Building Mesa (25.1.8)..."
	sleep 2
	patch -Np1 -i ../mesa-add_xdemos-4.patch
	mkdir build
	cd    build
	meson setup .. \
		--prefix=$XORG_PREFIX                      \
		--buildtype=release                        \
		-D platforms=x11                           \
		-D gallium-drivers=nouveau,virgl,svga,i915 \
		-D vulkan-drivers=intel,nouveau            \
		-D egl-native-platform=x11                 \
		-D video-codecs=all                        \
		-D build-tests=true                        \
		-D libunwind=disabled
	ninja

	echoL "Testing Mesa (25.1.8)..."
	sleep 2
	meson configure -D build-tests=true
	sed '/float rsqrtf/,/^}/d' -i ../src/gallium/drivers/llvmpipe/lp_test_arit.c
	ninja test

	echoL "Installing Mesa (25.1.8)..."
	sleep 2
	ninja install
	cp -rv ../docs -T /usr/share/doc/mesa-25.1.8

	echoL "Cleaning up build area...."
	sleep 2
	cd /sources
	rm -fR mesa-25.1.8

	echoL "Exiting..."
}

lfs_identity
lfs_tmux_entry main  # must be called after the routine it defines.

exit 1
