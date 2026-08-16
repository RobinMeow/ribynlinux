#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

info "Installing core packages..."

run_on_arch sudo pacman -S --needed --noconfirm \
	base-devel \
	wireplumber \
	gawk \
	git \
	curl \
	zsh \
	eza \
	vi \
	vim \
	rsync \
	unzip \
	xclip \
	wl-clipboard \
	openssh \
	navi \
	fastfetch \
	bc \
	ncdu \
	man-db \
	man-pages \
	tealdeer \
	vlc \
	vlc-plugins-all \
	lnav \
	tree \
	btop \
	translate-shell \
	tokei \
	ffmpeg \
	7zip \
	ripgrep \
	glow \
	mpv \
	chafa \
	fd \
	bluetui \
	gource \
	words \
	detox \
	git-lfs \
	wev \
	nodejs \
	nvm \
	docker \
	docker-compose \
	docker-buildx \
	postgresql \
	jq

# WARN: i remember targeting pack being a bug fix for dotnet
# specifically for archlinux. but I ll wait until I run into it again.
# It might not occur anymore, since I include latest verson install
# in neovim by default now.
#
# dotnet-runtime \
# dotnet-sdk \
# aspnet-runtime \
# aspnet-targeting-pack \

run_on_fedora sudo dnf install -y \
	@development-tools \
	wireplumber \
	git \
	gawk \
	curl \
	zsh \
	eza \
	vi \
	vim \
	rsync \
	unzip \
	xclip \
	wl-clipboard \
	openssh \
	navi \
	fastfetch \
	bc \
	ncdu \
	man-db \
	man-pages \
	tealdeer \
	vlc \
	lnav \
	tree \
	btop \
	translate-shell \
	tokei \
	7zip \
	ripgrep \
	glow \
	mpv \
	chafa \
	fd-find \
	gource \
	words \
	detox \
	git-lfs \
	wev \
	nodejs \
	docker \
	docker-compose \
	postgresql \
	jq

run_on_fedora sudo dnf install -y --allowerasing \
	ffmpeg

if ! tldr --update; then
	# Error: Could not update cache
	# Caused by:
	#     Could not download tldr pages from https://github.com/tldr-pages/tldr/releases/latest/download//tldr-pages.en_US.zip: Err(Io(Custom { kind: UnexpectedEof, error: "Peer disconnected" }))
	warn "[pm-core] tldr --update failed; tldr pages might not be available or out of date. Usually becuase github is currently down. Just run it later." >&2
	press_any_to_continue
fi

success "Core packages installed"
