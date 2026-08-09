#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

RIBYN_ROOT_LOG_INFO=true info "Installing core packages..."

source "$RIBYN_ROOT/lib/run_on_distro.sh"
#
# INFO: just silencing nvim warnings with these: php composer jdk-openjdk julia

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		base-devel \
		wireplumber \
		gawk \
		git \
		curl \
		zsh \
		eza \
		vi \
		vim \
		go \
		rsync \
		tree-sitter-cli \
		unzip \
		xclip \
		wl-clipboard \
		openssh \
		navi \
		fastfetch \
		bc \
		ncdu \
		cargo \
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
		php composer jdk-openjdk julia \
		wev
EOF

run_on_fedora <<'EOF'
	sudo dnf install -y \
		@development-tools \
		wireplumber \
		git \
		gawk \
		curl \
		zsh \
		eza \
		vi \
		vim \
		golang \
		rsync \
		tree-sitter-cli \
		unzip \
		xclip \
		wl-clipboard \
		openssh \
		navi \
		fastfetch \
		bc \
		ncdu \
		cargo \
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
    php composer java-devel julia \
		wev

	sudo dnf install -y --allowerasing ffmpeg
EOF

tldr --update

RIBYN_ROOT_LOG_INFO=true success "Core packages installed"
