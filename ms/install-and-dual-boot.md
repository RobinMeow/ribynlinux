# Install Windows 11

covers new win11 installations and dual boot setups.

## Make a bootable usb drive

> replace <> with your file names and usb name

windows is different to linux distros and requires specific partitions.
so your usually `cp` command will not work and result in a media drivers
missing error.
So we are using woeusb so we don't need to manully do the partitions etc..

1. download the windows 11 iso [win11 iso download](https://www.microsoft.com/en-au/software-download/windows11)
2. download the latest bash script from the release page [woeusb](https://github.com/WoeUSB/WoeUSB)
3. make it executable `chmod +x ~/Downloads/<woeusb_bash>`
4. plugin your usb drive, unmount it if you pc automatically mounts it
5. find your usb using `lsblk`
6. `sudo ~/Downloads/<woeusbbash> --device ~/Downloads/<Win11.iso> /dev/<sdX>`

## Dual Boot

[arch wiki - Dual boot with Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
covers dual booting in great detail

## Installation wizard

at some point it will ask for microsoft login.
Hopefully you can bypass using `SHIFT + F10`
and run `start ms-cxh:localonly`
ask AI what other methods to try, if it doesnt work, on your current win11
version.

## After installation

[disable hibernation and fast startup](https://wiki.archlinux.org/title/Dual_boot_with_Windows#Fast_Startup_and_hibernation)

1. in a cmd shell run: `powercfg /H off`
2. after disabling, shutdown (using the shutdown button, not restart)
to apply the settings.
