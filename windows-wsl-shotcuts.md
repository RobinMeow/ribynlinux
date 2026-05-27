# How to create Windows WSL Shortcuts to launch wsl in linux only supported terminal emulator

1. find the wslg.exe and create shortcut
2. change the target to `"C:\Program Files\WSL\wslg.exe" -d fedora --cd "~" -- kitty --start-as maximized`

optionally
- move it to you windows home folder (optional)
- type the distro name into the startmenu which should show up, right click prop, change icon, copy the path, set it for the new shortcut (optional)
- change the file name of the shotcut to something like fedora-kitty-launcher (optional)
- put it into you taskbar (optional)

C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\archlinux
also contains a launcher
