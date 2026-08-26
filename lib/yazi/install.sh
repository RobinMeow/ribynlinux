#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/ensure-installed-homebrew.sh"

brew install --no-ask \
	yazi \
	resvg

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		chafa \
		ffmpeg \
		7zip \
		jq \
		poppler \
		fd \
		ripgrep \
		fzf \
		imagemagick \
		extra/mediainfo \
		feh \
		file \
		mpv
elif on_fedora; then
	# erase ffmpeg-free if it is installed
	sudo dnf install -y --allowerasing \
		ffmpeg

	sudo dnf install -y \
		chafa \
		7zip \
		jq \
		poppler \
		fd-find \
		ripgrep \
		fzf \
		ImageMagick \
		mediainfo \
		feh \
		file \
		mpv
fi

# NOTE: image, audio, video, subtitle and many media files using ffmpeg and mediainfo metainfo
dest_mediainfo="$HOME/.config/yazi/plugins/mediainfo.yazi"

if [[ ! -d $dest_mediainfo ]]; then
	# install
	mkdir -p "$dest_mediainfo"
	git clone "https://github.com/boydaihungst/mediainfo.yazi" "$dest_mediainfo"
else
	# update
	git -C "$dest_mediainfo" pull
fi
