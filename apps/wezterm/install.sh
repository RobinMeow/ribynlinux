#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm wezterm
run_on_fedora <<'EOF'
sudo dnf copr enable -y wezfurlong/wezterm-nightly
sudo dnf install -y wezterm
EOF

"$RIBYN_ROOT/apps/wezterm/sync.sh"
