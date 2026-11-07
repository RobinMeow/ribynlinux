#!/usr/bin/env bash
set -euo pipefail

echo "uses 24fps and 720p by default. Use 480p for long videos or cut into smaller ones using mpv-cut."

input_file=${1:"input file required as 1st arg"}
output_file=${2:"output file required as 2nd arg"}
fps=${3:?"24"}
resolution=${4:?"720"}

exec ffmpeg -i \
	"$input_file" \
	-vf "scale=-2:$resolution,fps=$fps" -c:v libx264 -crf 32 -c:a aac -b:a 48k \
	"$output_file"
