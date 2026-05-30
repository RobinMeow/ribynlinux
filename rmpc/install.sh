#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm rmpc mpd extra/timidity++

run_on_fedora sudo dnf install -y mpd timidity++

# https://rmpc.mierak.dev/installation/#using-cargo
run_on_fedora sudo dnf install -y cargo
run_on_fedora cargo install rmpc --locked

"$RIBYNS_ENV/rmpc/sync.sh"
