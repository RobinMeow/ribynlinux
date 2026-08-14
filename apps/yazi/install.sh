#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/ensure_installed_homebrew.sh"

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
	sudo dnf install -y \
		chafa \
		ffmpeg \
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
