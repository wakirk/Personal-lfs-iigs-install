#!/bin/bash

echo "whoami: $(whoami)"
echo "id: $(id)"
echo "pwd: $PWD"
echo "HOME: $HOME"
echo "LFS: $LFS"
echo "PATH: $PATH"
env | sort | less
echo
bash
/bin/bash

