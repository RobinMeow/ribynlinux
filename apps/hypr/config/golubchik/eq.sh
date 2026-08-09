#!/usr/bin/env bash
set -euo pipefail

RAMFILE="/dev/shm/cava_output.txt"

# check music (optional check. can use mpc instead)
# just a condition for whether or not, it should show the
# visualliser
if [[ "$(playerctl status 2>/dev/null)" != "Playing" ]]; then
	echo ""
	exit 0
fi

# read file
line=$(cat "$RAMFILE" 2>/dev/null)

# check that the file is not empy
if [[ -z "$line" ]]; then
	echo ""
	exit 0
fi

output=""

# convert values to unicode blocks

for value in ${line//;/ }; do
	if ((value > 16)); then value=16; fi
	level=$((value / 2))
	case $level in
	0) output+="  " ;;
	1) output+="▁ " ;;
	2) output+="▂ " ;;
	3) output+="▃ " ;;
	4) output+="▄ " ;;
	5) output+="▅ " ;;
	6) output+="▆ " ;;
	7) output+="▇ " ;;
	8) output+="█ " ;;
	esac
done

echo "$output"
