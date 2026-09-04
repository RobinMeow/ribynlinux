# Ribyns Environment

My personalized environment for Arch Linux, Fedora, Neovim, WSL and many other things.

![gource](./gource-august.png)
[gourced full history](./gourced.md)

> checkout [installers and helpers](./installers.md) for first time clones / installs

## Git Revisions

if you want to override values locally (per machine) use your zshrc local
located in ~/.config/ribyn/zsh/local.sh

when using branches for GIT_REV always include the remote prefix: `origin/<branch>`
it seems redundant, becuase its always origin/ for branches, but currently our script
has not way of telling,
if the GIT_REV is a hash, tag or branch
specifying a branch, also enabled auto updating. Otherwise choose a commit or tag.
a tag can be updated by the maintainers, and can cause a unpredictable update.
(and commits can be lost, if the maintainers decide to get rid of it)

## Syncing config files with rsync

```sh
# --recursive, -r          recurse into directories
# --links, -l              copy symlinks as symlinks
# --perms, -p              preserve permissions
# --times, -t              preserve modification times
# --verbose, -v
```

## Setup remotes

when cloning from gh

```sh
cd "$RIBYN_ROOT"
git remote rename origin gh
git remote add cb ssh://git@codeberg.org/Ribyn/ribynlinux.git
git config remotes.all "gh cb"
```

## generating ssh key

```sh
# recommended
ssh-keygen -t ed25519 -C "your-comment"
# optinally older key
ssh-keygen -t rsa -b 4096 -C "your-comment"

ssh-keyscan -H github.com >>~/.ssh/known_hosts
ssh-keyscan -H codeberg.org >>~/.ssh/known_hosts
```

## MonkeyType 

100% acc
![monkeytype](./monkey.png)

<100% acc
![monkeytype](./monkey-fastest-with-errors.png)

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

