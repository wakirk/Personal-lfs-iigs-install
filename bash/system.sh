#!/bin/bash

# 1) PCI devices and the driver IN USE for each
lspci -nnk | awk '/^[0-9a-f]{2}:[0-9a-f]{2}\./{d=$0}/Kernel driver in use:/ {print d "\n  -> " $0 "\n"}'

# 2) USB tree with drivers currently bound
lsusb -t    # look for Driver=... on each node

# 3) The **exact kernel modules** currently bound to hardware (from sysfs)
for m in /sys/bus/*/drivers/*/*/driver/module; do
  readlink -f "$m" | xargs -r basename
done | sort -u


