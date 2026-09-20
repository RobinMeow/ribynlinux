#!/usr/bin/env bash
set -euo pipefail

FILE=${1:?file as 1st arg required}
NOISE=${2:-"-48dB"}
MIN_SONG_LENGTH=${3:-"105"} # 1min 45s
TARGET_SILENCE=${4:-"0.45"}
MAX_SONG_LENGTH=${5:-"360"}

# We hardcode ffmpeg to find EVERY pause >= 0.1s so AWK has all the data it needs to fall back.
MIN_DETECT_DUR="0.1"

ffmpeg -hide_banner -i "$FILE" -af silencedetect=noise="$NOISE":d="$MIN_DETECT_DUR" -f null - 2>&1 |
	awk -v min_len="$MIN_SONG_LENGTH" -v max_len="$MAX_SONG_LENGTH" -v target_dur="$TARGET_SILENCE" '
BEGIN {
    num_silences = 0;
    total_sec = 0;
}

# Capture total audio duration from ffmpeg header
/Duration:/ {
    split($2, d, "[:,]");
    total_sec = (d[1] * 3600) + (d[2] * 60) + d[3];
}

/silence_start:/ {
    for (i = 1; i <= NF; i++) {
        if ($i ~ /silence_start:/) cur_start = $(i+1) + 0;
    }
}

/silence_end:/ {
    cur_end = 0; cur_dur = 0;
    for (i = 1; i <= NF; i++) {
        if ($i ~ /silence_end:/) cur_end = $(i+1) + 0;
        if ($i ~ /silence_duration:/) cur_dur = $(i+1) + 0;
    }
    
    # Store every tiny silence in arrays to process later
    num_silences++;
    starts[num_silences] = cur_start;
    ends[num_silences] = cur_end;
    if (cur_dur == 0) cur_dur = cur_end - cur_start;
    durs[num_silences] = cur_dur;
}

END {
    song_start = 0;
    current_i = 1;

    # Smart playhead loop
    while (current_i <= num_silences) {
        best_k = -1;
        best_dur = -1;
        found_ideal = 0;

        # 1. Look for the ideal cut in the window [min_len -> max_len]
        for (j = current_i; j <= num_silences; j++) {
            
            # Too short? Skip it.
            if (starts[j] + 1.0 - song_start < min_len) continue;

            # Exceeded 6 minutes? Stop looking in this window.
            if (starts[j] - song_start > max_len) break;

            # If we find our ideal target duration (e.g. 0.45s), take it immediately!
            if (durs[j] >= target_dur) {
                best_k = j;
                found_ideal = 1;
                break;
            }

            # Otherwise, track the longest pause we can find in this window (Fallback)
            if (durs[j] > best_dur) {
                best_dur = durs[j];
                best_k = j;
            }
        }

        # 2. If no valid pauses were found in the 6 min window at all, lift the limit
        if (found_ideal == 0 && best_k == -1) {
            for (j = current_i; j <= num_silences; j++) {
                if (starts[j] + 1.0 - song_start >= min_len) {
                    best_k = j;  # Grab the first available pause, even if its at 10 mins
                    break;
                }
            }
        }

        # 3. If STILL nothing was found, we are out of silences. Break out to handle the final track.
        if (best_k == -1) break;

        # 4. Perform the math for the chosen cut
        song_end = starts[best_k] + 1.0;
        next_start = ends[best_k] - 0.5;
        if (next_start < 0) next_start = 0;

        printf "1:%.6f:%.6f\n", song_start, song_end;
        
        # Advance the playhead
        song_start = next_start;
        current_i = best_k + 1;
    }

    # 5. Cut final track to the end of file
    if (total_sec > song_start && (total_sec - song_start) >= min_len) {
        printf "1:%.6f:%.6f\n", song_start, total_sec;
    }
}'
