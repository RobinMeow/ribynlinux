# microslop

## WSL / Slop

**Wezterm**
Terminal Emulator is `wezterm`.
Kitty is supported, but performance is worse.
Drastically worse on fedora.
On arch it can be improved but, I dont think I have automated this,
and forgot what exactly I did.

The font needs to be installed on windows to be available for wezterm.
You can download it here [website.org](https://wezterm.org)
and drag and drop it into fonts.

**Neovim**
nvim path `%AppData%/local/nvim`
but Telescope and maybe other features using the Linux ecosystem do not work.
I had no need to make support for this yet, since I only use nvim within wsl.

### CSharp LSP

install .NET stuff and add `~/.dotnet/tools`  to the path variable
because its recommended tho use those to install the csharp-ls
`dotnet tool install --global csharp-ls`
[wiki archlinux .NET](https://wiki.archlinux.org/title/.NET)

> this is installed by my nvim plugin mason.
> just make sure dotnet bin is in path available to nvim

## EFCore

install efcore tools:
`dotnet tool install --global dotnet-ef`

## UserSecrets

usersecrets / user secrets / user-secrets
are found in `~/.microsoft/usersecrets/<guid-which-corresponds-to-csproj-file>/secrets.json`

`dotnet user-secrets init` writes to the .csproj file the assigned guid

either create the json file and the guid dir manually or run:
`dotnet user-secrets set a b` (where a is key and b is value)

adding/chaning json values _(honestly its easier to just edit the file directly)_
`dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "/path/to/project"`

## other useful stuff I learned

you can install templates with the dotnet cli. e.g. xunit3 classlib

## NVIM

dotnet (meaning, microslop) is a mess, I use easy-dotnet nvim plugin now,
which is bloated but works pretty reliably at least.

---

## How to create Windows WSL Shortcuts to launch wsl in linux only supported terminal emulator

1. find the wslg.exe and create shortcut
2. change the target to
  `"C:\Program Files\WSL\wslg.exe" -d fedora --cd "~" -- kitty --start-as maximized`
3. change default shell `chsh -s /bin/zsh` while logged in as your user

optionally

- move it to you windows home folder (optional)
- type the distro name into the startmenu which should show up, right click prop,
  change icon, copy the path, set it for the new shortcut (optional)
- change the file name of the shotcut to something like fedora-kitty-launcher (optional)
- put it into you taskbar (optional)

C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\archlinux
also contains a launcher

for fedora distro install those:
```sh
# these two are definetly needed, fixed first two errors:
sudo dnf install -y libwayland-egl libwayland-cursor

# these (or one or more of them) fixed the segmentation error (taken from my hyprland deps)
sudo dnf install --assumeyes \
  wayland-protocols-devel \
  xorg-x11-server-Xwayland \
  wayland-devel

# if doesnt work, run ai stuff:
sudo dnf install libwayland-egl mesa-libEGL libglvnd-gles libwayland-egl-devel mesa-libEGL-devel libwayland-cursor libwayland-client libxkbcommon wayland-devel libX11-devel libXcursor-devel libXrandr-devel libXinerama-devel libXi-devel
```

---

## Make Windows less bad

### package manager

[scoop](https://github.com/ScoopInstaller/Scoop)

> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> `Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression`
>
> Why scoop? Choose scoop, because it seemed the most linux-like by using
> the user folder for installs (avoid annoying admind prompts)

### GlazeWM

[GlaveVM](https://github.com/glzr-io/glazewm)

> tiling windows manager. Tiling window managers are the go-to choice for most
> non-nvidia linux users now-a-days (increasing)

### Zebar

[zebar](https://github.com/glzr-io/zebar)

> Customizable taskbar (tho the default is pretty good)

### PowerToys

[power toys](https://github.com/microsoft/PowerToys)

> for the command palette to open apps instead of the windows search
> which is bloated af

[Source](https://github.com/vimichael/make-windows-pretty)
[showcase of those tools](https://www.youtube.com/watch?v=G0_wVLhI-Ds)

you can use powertoys for a keyboard manger.
Makes it easier to swap caps esc.
Microsoft keyboard layout creator for setting no dead keys.

### Enable long file paths

open regedit (Registry Editor)
nav to `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`
change `LongPathsEnabled` to value `1` which enables it.
if it doesnt exist:
1. right click
2. new
3. DWORD 32 bit
4. name `LongPathsEnabled`
5. click click, modify set to `1`

