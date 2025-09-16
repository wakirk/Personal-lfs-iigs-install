source /root/lfs/lib/tmux.sh
cd /root/lfs/Host

echoR "Setting up Workspace"

echoL "Configuring Host"
echo Configure Host...

echoL "Installing Host Software"
./pacman-host-setup.sh

echoL "Installing QEMU Emulator"
./qemu-test.sh

echoL "Version Check"
./version-check.sh

echo 'export LFS=/mnt/lfs' >> /root/.bash_profile
echo 'umask 022' >> /root/.bash_profile
echo 'export LFS=/mnt/lfs' >> /home/wakirk/.bash_profile
echo 'umask 022' >> /home/wakirk/.bash_profile

echoL "Host Configure Complete"
exit 0  # return sucess.

