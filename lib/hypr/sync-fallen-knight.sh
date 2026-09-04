#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/hypr/env.sh"
[[ "$RIBYN_HYPR_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "syncing hypr fallen-knight $RIBYN_HYPR_MPVPAPER_RESOLUTION"

if [[ "$RIBYN_HYPR_MPVPAPER_RESOLUTION" == "1440p" || "$RIBYN_HYPR_MPVPAPER_RESOLUTION" == "1080p" ]]; then
	(
		filename="fallen-knight-blossom-field-$RIBYN_HYPR_MPVPAPER_RESOLUTION.mp4"
		cd "$RIBYN_ROOT"
		# restore puts it into working directory instead of staging
		git restore --source=gh/fallen-knight -- "assets/motions/$filename"
		# git checkout gh/fallen-knight "assets/motions/$filename"

		mkdir -p "$HOME/.config/hypr"

		mv \
			"$RIBYN_ROOT/assets/motions/$filename" \
			"$HOME/.config/hypr/background-motion.mp4"
	)

	rsync -rlpt \
		"$RIBYN_ROOT/lib/hypr/optimized-background-motion.sh" \
		"$HOME/.config/hypr/optimized-background-motion"
fi
