I purchaed one of the C64 models that perifractic had purchsed before he bought Commodore, it's the same model as his,
save for the fancy keyboard, mine's a breadbin version, so, a classic look.

But when I grew up, all I had were apples. IIe, and IIe+, etc.  I always wanted a IIgs, but couldn't afford it.

Well, when I got this machine, it has a wildly unlocked EFI BIOS, features I've never seen, and one of fastest booting
startups I have ever layed eyes on. it's almost instnat.  Well, I want to fake an apple IIgs, so I am buildng my own linux
and I am gonna strip it down to just run an apple IIgs emulator,  This is that process.  I am going to make linux boot 
as fast as possible and cover up any extras with a cover screen to fake an apple IIgs boot up when I turn it on, I 
have other plans too, but those come later.

This project is not meant for public consumption, but it's not private either, ChatGPT is helping me for the stuff I don't
know.  It is AS IS, and a WIP ONLY, and not finished by far.

The setup is SystemRescue 11.02 (x86_64) (https://www.system-rescue.org/) on a usb stick using easy2boot as a loader for the .iso
[http://www.easy2boot.xyz](https://easy2boot.xyz/create-your-website-with-blocks/make-an-e2b-usb-drive/)

I have my D: shared, and I have a script that sets up telnet, I also have WSL 
so, 

Windows:
   D:\LFS is the work, this is where git is run from.
   D:\  is shared, work is in \LFS
   WSL installed, using telnet (local, so no security needed) nothing on this system to care about.
C64 Booted via USB -> Easy2Boot in wFM mode, -> System Rescue -> Load all into RAM.
   I mount the drive on /mnt/net/d and a link /root/lfs to it and we are off to the races, 

The Build System is part of the scripts. It grabs from pacman all the needed build systems to do the first stage of LFS, I think.
again, this is WIP and not meant for public use, no support is avaliable, none will be provided. again, I needed this for ChatGPT.



