# lazycut

lazycut only supports videos.

## Usage

```bash
lazycut video.mp4              # interactive TUI
lazycut video.mp4 --fps 12     # custom preview frame rate
lazycut trim --in 00:01:00 --out 00:02:00 -o out.mp4 video.mp4
lazycut probe video.mp4
```

## Keyboard Shortcuts

| Key | Action |
| --- | --- |
| `Space` | Play/Pause |
| `h` / `l` | Seek ±1s |
| `H` / `L` | Seek ±5s |
| `←` / `→` | Seek ±5s |
| `Shift+←` / `Shift+→` | Seek ±1s |
| `↑` / `↓` | Seek ±1 minute |
| `,` / `.` | Seek ±1 frame |
| `0` | Go to start |
| `G` / `$` | Go to end |
| `i` / `o` | Set in/out points |
| `X` | Remove last section |
| `p` / `P` | Preview all / last section |
| `d` / `Esc` | Clear selection |
| `Enter` | Export |
| `u` | Undo |
| `m` | Toggle mute |
| `?` | Help |
| `q` | Quit |

Vim-style repeat counts: `5l` = seek 5s forward, `10.` = step 10 frames.

## Export

Supports multiple sections per video, separate or concatenated export,
and aspect ratio conversion (16:9, 9:16, 1:1, 4:5).
