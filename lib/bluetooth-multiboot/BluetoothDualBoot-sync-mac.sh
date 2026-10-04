#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

dryrun=""
# dryrun="--dry-run"

bak="$HOME/.local/share/ribyn/bt-dualboot"
mkdir --parents "$bak"
info "backup will be stored in $bak"

mnt="/mnt/c"
if ! confirm "windows partition at: $mnt"; then
	error "user canceled the operation. retry after specifying the correct window mount."
	exit 1
fi

# --bot flag enables better parsable output for usage in scripts
macaddress=${1:?"mac address as 1st arg required. use sudo bt-dualboot --list to find em."}
# should like this:
# sudo bt-dualboot --sync C2:9E:1D:E2:3D:A5
sudo bt-dualboot $dryrun \
	--bot \
	--backup "$bak" \
	--win "$mnt" \
	--sync "$macaddress"
