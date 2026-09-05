#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

info "installing core packages"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		wireplumber \
		zsh \
		eza \
		vi \
		vim \
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
		jq \
		openvpn \
		ufw \
		exfatprogs \
		kdiskmark

# WARN: i remember targeting pack being a bug fix for dotnet
# specifically for archlinux. but I ll wait until I run into it again.
# It might not occur anymore, since I include latest verson install
# shouldn't be needed anymore, just run the dotnet install script with --version "latest"
#
# dotnet-runtime \
# dotnet-sdk \
# aspnet-runtime \
# aspnet-targeting-pack \

elif on_fedora; then
	sudo dnf install -y \
		wireplumber \
		zsh \
		eza \
		vi \
		vim \
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
		gource \
		words \
		detox \
		git-lfs \
		wev \
		nodejs \
		docker \
		docker-compose \
		postgresql \
		jq \
		openvpn \
		ufw \
		exfatprogs \
		kdiskmark

	sudo dnf install -y --allowerasing \
		ffmpeg
fi

if ! tldr --update; then
	# Error: Could not update cache
	# Caused by:
	#     Could not download tldr pages from https://github.com/tldr-pages/tldr/releases/latest/download//tldr-pages.en_US.zip: Err(Io(Custom { kind: UnexpectedEof, error: "Peer disconnected" }))
	warn "[core packages] tldr --update failed; tldr pages might not be available or out of date. Usually becuase github is currently down. Just run it later." >&2
	press_any_to_continue
fi

success "Core packages installed"
