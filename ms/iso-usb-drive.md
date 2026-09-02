# Windows Usb Drive

> replace <> with your file names and usb name

windows is different to linux distros and requires specific partitions.
so your usually `cp` command will not work and result in a media drivers
missing error.

download the latest bash script from the release page [woeusb](https://github.com/WoeUSB/WoeUSB)
make it executable `chmod +x ~/Downloads/<woeusb_bash>`

download the windows 11 iso [win11 iso download](https://www.microsoft.com/en-au/software-download/windows11)

plugin your usb drive, unmount it if you pc automatically mounts it.
find your usb `lsblk`
`sudo ~/Downloads/<woeusbbash> --device ~/Downloads/<Win11.iso> /dev/<sdX>`
