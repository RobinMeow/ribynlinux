#!/usr/bin/env bash
set -euo pipefail

# WARN: depends on
# - wpctl
# - awk

pipe="/tmp/wobvolume"
[[ -p "$pipe" ]] || mkfifo "$pipe"

function show_wob_volume() {
	VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

	# Extract the decimal and convert it to a whole percentage (e.g., 0.45 becomes 45)
	PERCENT=$(echo "$VOLUME_INFO" | awk '{print int($2 * 100)}')

	# 4. Feed it to Wob: send 0 if muted, otherwise send the percentage
	if [[ "$VOLUME_INFO" == *"[MUTED]"* ]]; then
		echo "0" >"$pipe"
	else
		echo "$PERCENT" >"$pipe"
	fi
}

case "$1" in
# The -l 1.0 flag safely caps your maximum volume at 100%
up)
	wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
	show_wob_volume
	;;
down)
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
	show_wob_volume
	;;
mute)
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	show_wob_volume
	;;
listen) exec tail -f "$pipe" | wob ;;
esac
