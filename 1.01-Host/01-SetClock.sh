#!/bin/bash

cd /home/lfs/lfs
source lib/menu.lib
cd 1.01-Host


echoR "Configuring Host"
echoL "Configuring Clock"

timedatectl set-timezone America/Chicago 
timedatectl set-ntp true  

exit 1

