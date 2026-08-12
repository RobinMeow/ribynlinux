#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

RIBYN_ROOT_LOG_INFO=true info "Installing core packages..."

source "$RIBYN_ROOT/lib/run_on_distro.sh"

# TODO: move nvim deps to nvim
# TODO: move programming / software dev deps to a module
# TODO: move cli tools to cli/install.sh

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

tldr --update

RIBYN_ROOT_LOG_INFO=true success "Core packages installed"
