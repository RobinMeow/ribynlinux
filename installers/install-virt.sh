#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm libvirt virt-manager virt-viewer qemu-full dmidecode dnsmasq openbsd-netcat
run_on_fedora sudo dnf install -y @virtualization

# mkdir -p "$HOME/.config/bat"
# cp -r "$RIBYN_ROOT/config/bat/"* "$HOME/.config/bat/"
