#!/usr/bin/env bash
set -euo pipefail

# nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | tr -d ' '

# NVIDIA
if command -v nvidia-smi >/dev/null 2>&1; then
	nvidia-smi \
		--query-gpu=utilization.gpu \
		--format=csv,noheader,nounits 2>/dev/null |
		awk '{sum += $1; n++} END {if (n) printf "%.0f\n", sum/n}'
	exit
fi

# AMD
for gpu in /sys/class/drm/card*/device/gpu_busy_percent; do
	if [[ -r "$gpu" ]]; then
		cat "$gpu"
		exit
	fi
done

# Intel
for gpu in /sys/class/drm/card*/gt_busy_percent; do
	if [[ -r "$gpu" ]]; then
		cat "$gpu"
		exit
	fi
done

# Unknown / unsupported GPU
echo "N/A"
