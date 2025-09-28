#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.
cd /root/lfs/1.01-Host


echoR "Configuring Host"
echoL "Configuring Clock"

timedatectl set-timezone America/Chicago >/dev/null 2>&1 || true
timedatectl set-ntp true                 >/dev/null 2>&1 || true

exit 1

