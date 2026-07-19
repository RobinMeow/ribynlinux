# Ribyns Environment

My personalized environment for Arch Linux, Fedora, Neovim, WSL and many other things.

![gource](./gource.png)

## Arch

```sh
export RIBYN_ROOT="$HOME/ribynlinux"
git clone ssh://git@codeberg.com:Ribyn/ribynlinux.git "$RIBYN_ROOT"
"$RIBYN_ROOT/bin/ribyn_install"
```

> `RIBYN_ROOT` environment variable is required by almost every script
> this is mostly only relevant for the first install. The zshrc exports this variable

> the ribyn_install script frequently changes, perhaps look into it to see which flags are supported

### Migrate from ribyns-env to ribynlinux

easiest way is to edit your .zshrc to export RIBYN_ROOT, source it and run ribyn_install

## Terminal Emulator

using `kitty` and optionally `wezterm` for wsl

## Oh my zsh default keybind

`CTRL+e` to accept ghost-like zsh-autosuggestions
`CTRL+r` search past commands _(this is default outside of omz, and I dont use it anyways I have my own fh fn for this)_

## WSL

**Wezterm**
Terminal Emulator is `wezterm`. 
Kitty is supported, but performance is worse. 
Drastically worse on fedora. 
On arch it can be improved but, I dont think I have automated this, and forgot what exactly I did.

The font needs to be installed on windows to be available for wezterm.
You can download it here [website.org](https://wezterm.org) and drag and drop it into fonts.

**Neovim**
nvim path `%AppData%/local/nvim`
but Telescope and maybe other features using the Linux ecosystem do not work.
I had no need to make support for this yet, since I only use nvim within wsl.

## Binaries

the `./bin` directory is added to `$PATH`, so all of those
scripts are available for ease of use.

### MonkeyType 

100% acc
![monkeytype](./monkey.png)

<100% acc
![monkeytype](./monkey-fastest-with-errors.png)

---

```
Sat Jun 20 11:21:42 PM CEST 2026
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Language              Files        Lines         Code     Comments       Blanks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BASH                     16          734          527           75          132
 Batch                     1           10            4            4            2
 CSS                       1           26           26            0            0
 INI                       1           18            5            9            4
 JSON                      1           53           53            0            0
 Lua                      36         2569         1893          455          221
 Rusty Object Nota|        2          568          568            0            0
 Shell                    66         2120         1358          394          368
 TOML                      5         1863         1673           98           92
 Zsh                       1         1720          443         1103          174
─────────────────────────────────────────────────────────────────────────────────
 Markdown                 20         1369            0         1020          349
 |- BASH                   5           12            9            2            1
 (Total)                             1381            9         1022          350
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Total                   150        11062         6559         3160         1343
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### FAQ / Troubleshooting

if the installer throws pacman errors when installer, make sure to update your system upfront: `sudo pacman -Syu`
then try again. none of the scripts update, but when installing new apps, it might fail, becuase it pulls their
latest version which might depend on newer bins
