# mpv

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
