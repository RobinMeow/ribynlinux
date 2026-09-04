#!/usr/bin/env bash
set -euo pipefail

mpv_options=(
	--no-audio
	--loop-file=inf
	--hwdec=auto
	--cache=no
	--wayland-internal-vsync=no
	--demuxer-seekable-cache=no
	--dither=no
	--correct-downscaling=no
	--linear-downscaling=no
	--sigmoid-upscaling=no
	--aid=no
	--sub-auto=no
	--autoload-files=no
	--cover-art-auto=no
	--demuxer-thread=no
	--demuxer-readahead-secs=0
	--osc=no
	--osd-level=0
	--really-quiet=no
	--term-osd=no
	--load-stats-overlay=no
	--load-console=no
	--load-commands=no
	--load-context-menu=no
	--load-positioning=no
	--load-scripts=no
	--load-select=no
	--taskbar-progress=no
	--config=no
	--input-cursor=no
	--input-default-bindings=no
	--input-media-keys=no
	--input-preprocess-wheel=no
	--input-right-alt-gr=no
	--input-tablet-emulate-mouse=no
	--input-tablet-emulate-mouse=no
	--input-terminal=no
	--input-touch-emulate-mouse=no
	--input-vo-keyboard=no
	--msg-color=no
	--show-in-taskbar=no
	--window-dragging=no
	--really-quiet=yes
)

exec mpvpaper ALL \
	"$HOME/.config/hypr/background-motion.mp4" \
	--mpv-options "${mpv_options[*]}"
