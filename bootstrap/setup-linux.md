# Linux Setup (Fedora/Arch)

To prepare a Fedora or Arch Linux instance, run the following command. The script installs base packages (zsh, vim, sudo, git), optionally creates a new user, clones the repository, and starts the installation.

## Quick Start

> setup script is in rework. wip on archinstaller

```bash
sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribynlinux/raw/branch/master/scripts/setup-linux.sh)"
SKIP_INSTALL=true sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribynlinux/raw/branch/master/scripts/setup-linux.sh)"
```

or manually (Recommended: the setup script is iffy):
```bash
export RIBYN_ROOT="$HOME/ribynlinux"
git clone ssh://git@codeberg.org:Ribyn/ribynlinux.git $RIBYN_ROOT
$RIBYN_ROOT/scripts/install.sh --full-install
```

---

## setup user your user with wheel and sudo

```bash
# as `root`:
# deps
pacman -Syu --noconfirm
pacman -S --noconfirm sudo git bc vim
dnf install -y sudo git bc vim

# add grups
groupadd sudo
groupadd wheel

# activate wheel find and uncomment: "# %wheel ALL=(ALL:ALL) ALL"
# manually:
EDITOR=vim visudo
# or using sed :
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# same for sudo
sed -i 's/^# %sudo ALL=(ALL:ALL) ALL/%sudo ALL=(ALL:ALL) ALL/' /etc/sudoers

# create the user and set pw
useradd -m -G sudo,wheel -s /usr/bin/bash ribyn
passwd ribyn
# login into the user
su - ribyn
```

> both commented lines are available on arch
