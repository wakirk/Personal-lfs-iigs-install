#!/bin/bash

#Usage:   <URL> <FILENAME>
#ex: /root/lfs/bash/download https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz m4-1.4.19.tar.xz

URL="$1"
FILE="$2"
PKGDIR="/home/lfs/lfs/Packages"

echo "Download:    $1 to File $PKGDIR/$FILE"

# Make sure the packages directory exists
mkdir -p "$PKGDIR"

# If the file already exists, do nothing
if [ -f "$PKGDIR/$FILE" ]; then	
    echo "Already have $FILE in $PKGDIR"
else
    echo "Fetching $URL -> $PKGDIR/$FILE"
    wget -O "$PKGDIR/$FILE" "$URL"
	if [ $? -ne 0 ]; then
		# https or ftps not avalaible. 
		# URL=${URL/#https:/http:}; URL=${URL/#ftps:/ftp:}
		wget  --no-check-certificate -O "$PKGDIR/$FILE" "$URL"
		if [ $? -ne 0 ]; then
			rm "$PKGDIR/$FILE"
		fi
	fi
fi

