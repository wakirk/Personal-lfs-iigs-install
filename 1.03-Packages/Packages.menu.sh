#!/bin/bash


# sudo mount -o remount,uid=$(id -u lfs),gid=$(id -g lfs) /mnt/net/d

echo "Who AM I?"
whoami
cd ~
pwd
ls

read

# Exported env, sorted
env | sort

# Exported env, robust for weird characters
env -0 | sort -z | tr '\0' '\n'

# Bash-exported (matches `export -p`), simplified to KEY=VAL
export -p | sed -E 's/^declare -x ([^=]+)(="?.*)?$/\1\2/' | sort

read


----

#!/usr/bin/env bash
# Root driver script (run as root)

# Path to the sub-script you want to run as lfs:lfs
SUBSCRIPT="/path/to/subscript.sh"   # adjust

# Run it as lfs:lfs, as a *login* bash so rc files are read
# -u lfs : switch user
# -g lfs : set primary group (kept even if lfs already defaults to lfs)
# -H     : HOME becomes ~lfs so dotfiles resolve correctly
# bash -lc '…' : login shell (-l) reads /etc/profile and ~lfs/.bash_profile (which typically sources ~/.bashrc)

sudo -u lfs -g lfs -H bash -lc "${SUBSCRIPT@Q}"
--
sudo -i -u lfs -g lfs bash -lc "${SUBSCRIPT@Q}"

rc=$?
echo "Sub-script exited with status: $rc"
exit "$rc"


