#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/vale"

if [[ -f "$HOME/.config/vale/vale.ini" ]]; then
	hash_before_sync=$(cksum -a sha256 --untagged "$HOME/.config/vale/vale.ini")

	ribyn_rsync \
		"$RIBYN_ROOT/apps/vale/config/vale.ini" \
		"$HOME/.config/vale/vale.ini"

	if [[ "$(cksum -a sha256 --untagged "$HOME/.config/vale/vale.ini")" != "$hash_before_sync" ]]; then
		vale --config "$HOME/.config/vale/vale.ini" sync
	fi
else
	ribyn_rsync \
		"$RIBYN_ROOT/apps/vale/config/vale.ini" \
		"$HOME/.config/vale/vale.ini"

	vale --config "$HOME/.config/vale/vale.ini" sync
fi
