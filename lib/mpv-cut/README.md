# mpv

## tldr;

```sh
# 1. download the music mix using yt-dlp
yt-dlp -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=FyzAhqmV6ak"

# generate a list file using the smart script (instead of using mpv manually)
# and redirect it into a same named file with .list suffix
"$RIBYN_ROOT/lib/mpv-cut/ffmpeg-silence-detect-smart.sh" \
  ./yt-dlp-output-file.mp3 \
  >./yt-dlp-output-file.mp3.list

# source mpvcut utils
"$RIBYN_ROOT/lib/mpv-cut/utils.sh"

# call the util and feed the list file into it
make_cuts ./yt-dlp-output-file.mp3.list
```

## cutting audio files

make sure to use exact seeking to make cuts.
and dont seek into negative time *(its not shown but mpv-cut supports it, and
then throws an error)*

default keybindings:

## Usage 

### Playback & Seeking

| Key | Action |
| --- | --- |
| `SPACE` or `p` | Toggle pause / playback |
| `LEFT` / `RIGHT` | Seek 5 seconds backward / forward |
| `UP` / `DOWN` | Seek 60 seconds forward / backward |
| `Shift` + `LEFT` / `RIGHT` | Seek 1 second backward / forward (exact seek) |
| `[` / `]` | Decrease / increase current playback speed by 10% |
| `{` / `}` | Halve / double current playback speed |
| `BACKSPACE` | Reset playback speed to `1.0x` |
| `.` / `,` | Step one frame forward / backward |
| `q` | Quit mpv |
| `Shift` + `q` (`Q`) | Save current playback position and quit |

### Audio & Subtitles

| Key | Action |
| --- | --- |
| `9` / `0` | Decrease / increase volume |
| `m` | Toggle audio mute |
| `#` | Cycle through available audio tracks |
| `v` | Toggle subtitle visibility on / off |
| `j` / `Shift` + `j` (`J`) | Cycle forward / backward through subtitle tracks |
| `z` / `Shift` + `z` (`Z`) | Adjust subtitle delay (+100 ms / -100 ms) |
| `Ctrl` + `Shift` + `LEFT` / `RIGHT` | Seek to previous / next subtitle line |

### Video, Display & System Stats

| Key | Action |
| --- | --- |
| `f` | Toggle fullscreen |
| `ESC` | Exit fullscreen mode |
| `s` | Take a screenshot |
| `Shift` + `s` (`S`) | Take a screenshot without subtitles |
| `Alt` + `s` | Take a screenshot with window scaling/subtitles |
| `o` / `P` | Show progress bar / persistent time elapsed and remaining |
| `i` / `Shift` + `i` (`I`) | Show stats overlay (codecs, frame drops, resolution) |
| `1` / `2` | Decrease / increase contrast |
| `3` / `4` | Decrease / increase brightness |
| `5` / `6` | Decrease / increase gamma |
| `7` / `8` | Decrease / increase saturation |
| `L` | Toggle looping for current file |

## mpv cut guide

Quick Reference: Keybindings

| **Key** | **Action** | **Notes** | 
| --- | --- | --- |
| `c` | **Start / Complete Cut** | Press once to set the start point; press again at the end point to export the clip immediately. |
| `C` (`Shift+c`) | **Cancel Cut** | Clears the current selection without exporting. |
| `a` | **Cycle Action Mode** | Toggles between `COPY` (lossless, instant), `ENCODE` (re-encoded), and `LIST` (saves timestamps to a text file). |
| `i` | **Bookmark Timestamp** | Saves timestamp to a `.book` file (optional). |
| `-` / `=` | **Change Channel** | Cycles channel numbers to organize cuts into separate subfolders/prefixes. |


Method A: just press c on song start, and c again on song end.
stay in COPY action mode. which is the default iirc. or cycle with `a`

Method B: Batch Export using `LIST` Mode

If you prefer to mark all cuts first and process them all in one go via command line:

1. Press **`a`** until the action is set to **`LIST`**.
2. Mark all song start and end points using **`c`** ... **`c`**. This appends timestamps to a `.list` text file next to your mix.
3. Once finished, open your terminal in that directory and run the included utility function:
   ```sh
   make_cuts "My 2 Hour Mix.mp3.list" -c copy
   ```

Troubleshoot:
* **Audio Artifacts / Pops at Boundaries?** Lossless cutting (`COPY`) cuts at frame boundaries. If you hear a click or pop at the edge of a track cut, switch the mode to **`ENCODE`** (press `a`) for frame-exact cuts with re-encoding.

dB settings for noise:

-70dB to -90dB (Pure Digital): Studio-grade stems, digitally generated silence, or very modern, cleanly mastered digital albums.

-50dB to -60dB (CD Rips): Standard commercial CDs. There is almost no noise between tracks, but the threshold doesn't need to be perfectly absolute.

-40dB to -45dB (Vinyl Rips): Vinyl records have inherent surface noise, pops, and turntable rumble. (Your script's default of -48dB is optimized for reasonably clean analog rips).

-30dB to -35dB (Cassette Tapes / Live Shows): High background hiss on tapes or crowd noise/amp buzz between songs at a live concert.
