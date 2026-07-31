#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

RIBYN_ROOT_LOG_INFO=true info "Installing core packages..."

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		base-devel \
		gawk \
		git \
		curl \
		zsh \
		eza \
		vi \
		vim \
		go \
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
		flameshot \
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
		git-lfs
EOF

run_on_fedora <<'EOF'
	sudo dnf install -y \
		@development-tools \
		git \
		gawk \
		curl \
		zsh \
		eza \
		vi \
		vim \
		golang \
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
		flameshot \
		7zip \
		ripgrep \
		glow \
		mpv \
		chafa \
		fd-find \
		gource \
		words \
		detox \
		git-lfs

	sudo dnf install -y --allowerasing ffmpeg
EOF

tldr --update

RIBYN_ROOT_LOG_INFO=true success "Core packages installed"
