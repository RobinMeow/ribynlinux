#!/usr/bin/env bash
set -euo pipefail

# https://github.com/yt-dlp/yt-dlp/wiki/Installation#third-party-package-managers

source "$RIBYN_ROOT/core/utils.sh"

mkdir -p "$HOME/.local/bin"
local_bin="$HOME/.local/bin/yt-dlp"

if [[ -x "$local_bin" ]]; then
	info "updating yt-dlp"
	"$local_bin" -U
else
	info "installing yt-dlp"
	curl -L "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" \
		-o "$local_bin"

	chmod a+rx "$local_bin"
fi
