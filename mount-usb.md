# How to mount a usb drive quickly

Here is the quick Linux command-line rundown for mounting a USB drive.

1. **Find the USB drive name:**

```bash
lsblk

```

Look at the sizes to identify your USB. The partition you want to mount will usually look something like `sdb1` or `sdc1`.

2. **Create a mount point:** (the directory persists for future mounts)

```bash
mkdir -p /mnt/usb

```

3. **Mount the drive:**
Attach the drive to the directory you just created. Make sure to replace `sdX1` with your actual drive partition from Step 1:

```bash
mount /dev/sdX1 /mnt/usb

```

You can now access your files by navigating to `/mnt/usb`.


4. **Unmount when finished:** Don't skip this or you risk data corruption.
Before physically pulling the USB out, safely unmount it:

```bash
sudo umount /mnt/usb

```

> **Tip:** The command is `umount` (without the first 'n'), which is a very common typo!
