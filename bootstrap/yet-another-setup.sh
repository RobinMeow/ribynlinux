#!/usr/bin/env bash
set -euo pipefail

# invoke as root (arch only for now)
# sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribynlinux/raw/branch/master/bootstrap/yet-another-setup.sh)"

# echo "installing deps"
# pacman -Syu --noconfirm
# pacman -S --noconfirm sudo git bc vim
# dnf install -y sudo git bc vim

echo "adding groups"
# -f, --force exit successfully if the group already exists
groupadd --force sudo
groupadd --force wheel

# activate wheel find and uncomment: "# %wheel ALL=(ALL:ALL) ALL"
# manually:
# EDITOR=vim visudo
# or using sed :
echo "activating wheel"
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "activating sudo"
sed -i 's/^# %sudo ALL=(ALL:ALL) ALL/%sudo ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "create user with sudo and wheel group"
useradd -m -G sudo,wheel -s /usr/bin/bash ribyn

echo "set user password"
passwd ribyn

echo "logging into user"
su - ribyn
