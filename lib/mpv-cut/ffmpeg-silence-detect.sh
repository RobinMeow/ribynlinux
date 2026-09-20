#!/usr/bin/env bash
set -euo pipefail

FILE=${1:?file as 1st arg required}
NOISE=${2:-"-48dB"}
MIN_SONG_LENGTH=${3:-"120"}
SILENCE_DURATION=${4:-"0.45"}

ffmpeg -hide_banner -i "$FILE" -af silencedetect=noise="$NOISE":d="$SILENCE_DURATION" -f null - 2>&1 |
	awk -v min_len="$MIN_SONG_LENGTH" '
BEGIN {
    song_start = 0;
    s_start = 0;
    s_end = 0;
    total_sec = 0;
}

# Capture total audio duration from ffmpeg header
/Duration:/ {
    split($2, d, "[:,]");
    total_sec = (d[1] * 3600) + (d[2] * 60) + d[3];
}

/silence_start/ {
    for (i = 1; i <= NF; i++) {
        if ($i ~ /silence_start:/) s_start = $(i+1) + 0;
    }
}

/silence_end/ {
    for (i = 1; i <= NF; i++) {
        if ($i ~ /silence_end:/) s_end = $(i+1) + 0;
    }
    
    song_end = s_start + 1.0;
    next_start = s_end - 0.5;

    if (next_start < 0) next_start = 0;

    if (song_end > song_start && (song_end - song_start) >= min_len) {
        printf "1:%.6f:%.6f\n", song_start, song_end;
        song_start = next_start;
    }
}

END {
    # Cut final track to end of file
    if (total_sec > song_start && (total_sec - song_start) >= min_len) {
        printf "1:%.6f:%.6f\n", song_start, total_sec;
    }
}'
