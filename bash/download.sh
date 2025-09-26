#!/bin/bash

#Usage:   <URL> <FILENAME>
#ex: /root/lfs/bash/download https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz m4-1.4.19.tar.xz

URL="$1"
FILE="$2"
PKGDIR="/root/lfs/packages"

# Make sure the packages directory exists
mkdir -p "$PKGDIR"

# If the file already exists, do nothing
if [ -f "$PKGDIR/$FILE" ]; then
    echo "Already have $FILE in $PKGDIR"
else
    echo "Fetching $URL -> $PKGDIR/$FILE"
    wget -O "$PKGDIR/$FILE" "$URL"
fi
