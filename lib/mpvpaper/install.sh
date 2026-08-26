#!/usr/bin/env bash
set -euo pipefail

# https://github.com/GhostNaN/mpvpaper

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		mpv \
		meson \
		ninja
elif on_fedora; then
	sudo dnf install --assumeyes \
		mpv-devel \
		meson \
		ninja
	# mpv-devel brings in mpv, and mpv-libs
fi

source "$RIBYN_ROOT/core/source-manager.sh"
source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/config.sh"

function build_and_install() {
	meson setup build --prefix=/usr/local
	ninja -C build
	sudo ninja -C build install
}
check_source_state "mpvpaper" "$RIBYN_MPVPAPER_GITREV"
giturl="https://github.com/GhostNaN/mpvpaper"
if [[ "$SOURCE_STATE" == "source n/a" ]]; then
	info "[$SOURCE_NAME] initialising..."
	init_source "$giturl"
	info "[$SOURCE_NAME] installing..."
	(cd "$SOURCE_DEST" && build_and_install)
elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
	if command -v mpvpaper >/dev/null 2>&1; then
		info "$SOURCE_NAME already installed. Skipping."
	else
		# edge case. means its already cloned, but build probably failed.
		clean_source
		info "[$SOURCE_NAME] installing..."
		(cd "$SOURCE_DEST" && build_and_install)
	fi
elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
	clean_source
	update_source "$giturl"
	info "[$SOURCE_NAME] updating..."
	(cd "$SOURCE_DEST" && build_and_install)
fi

# example use:
# favs with fit my color scheme
# fallen-knight
# japanese-night-village
# katana-forest (black white can always fit I guess)
# moonlit-bloom-cherry
# sakura-tree-landscape
# sakura-with-full-moon
# skyrim-cat
# temple-ruins-in-winter
# winter-cabin-by-the-lake
# cherry-blossoms (only if i implement keybinds for chaning brightness on blur bg)
#
# mpvpaper ALL ~/Videos/motions/cherry-blossoms-branches.3840x2160.mp4 --mpv-options "--no-audio --loop-file=inf --hwdec=auto"
#
# run yourself, or in autostart hyprland
# maybe works in kde too
# INFO: wl-freeze works just fine
#
# Set really-quiet to yes if you wanna see the console output
# NOTE: the important ones are:
# --hwdec=auto which utilises the GPU
# --no-audio
# --loop-file=inf
# the rest didnt seem to make much of an impact. I like to think, my times wasnt wasted tho.
#
#  mpvpaper ALL ~/Videos/motions/fallen-knight-blossom-field.3840x2160.mp4 --mpv-options "--no-audio --loop-file=inf --hwdec=auto --cache=no --wayland-internal-vsync=no --demuxer-seekable-cache=no --dither=no --correct-downscaling=no --linear-downscaling=no --sigmoid-upscaling=no --aid=no --sub-auto=no --autoload-files=no --cover-art-auto=no --demuxer-thread=no --demuxer-readahead-secs=0 --osc=no --osd-level=0 --really-quiet=no --term-osd=no --load-stats-overlay=no --load-console=no --load-commands=no --load-context-menu=no --load-positioning=no --load-scripts=no --load-select=no --taskbar-progress=no --config=no --input-cursor=no --input-default-bindings=no --input-media-keys=no --input-preprocess-wheel=no --input-right-alt-gr=no --input-tablet-emulate-mouse=no --input-terminal=no --input-touch-emulate-mouse=no --input-vo-keyboard=no --msg-color=no --show-in-taskbar=no --window-dragging=no --really-quiet=yes"
