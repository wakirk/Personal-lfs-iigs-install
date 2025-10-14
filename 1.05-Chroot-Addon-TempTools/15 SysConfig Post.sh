#!/bin/bash

source /root/lfs/lib/menu.lib   # In every script.

main () {

	echo "Cleaning up build area...."
	rm -vrf /usr/share/{info,man,doc}/*
	find /usr/{lib,libexec} -name \*.la -delete
	rm -vrf /tools

	echo "Exiting..."
}

main

exit 1
