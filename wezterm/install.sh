#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/utils.sh"
source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm wezterm
run_on_fedora <<'EOF'
sudo dnf copr enable -y wezfurlong/wezterm-nightly
sudo dnf install -y wezterm
EOF

"$RIBYNS_ENV/wezterm/sync.sh"
