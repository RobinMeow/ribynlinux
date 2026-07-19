#!/bin/bash
set -euo pipefail

source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/lib/utils.sh"

# default values are based on what guarantees a most stable system

GIT_REF="${RIBYN_NVIM_GIT_REF:-stable}"
verbose "Using git ref: $GIT_REF"

GIT_FETCH="${RIBYN_NVIM_GIT_FETCH:-false}"

function build_nvim() {
	verbose "Starting build process..."
	make CMAKE_BUILD_TYPE=RelWithDebverbose

	info "Installing Neovim..."
	sudo make install
}

REPO_DEST="$HOME/neovim"
if [ -d "$REPO_DEST" ]; then
	cd "$REPO_DEST" || exit 1

	if $GIT_FETCH; then
		info "Fetching $GIT_REF"
		git fetch --depth 1 origin $GIT_REF
	fi

	commit_hash_before_checkout=$(git -C "$REPO_DEST" rev-parse HEAD)
	git checkout "$GIT_REF"
	if [[ $commit_hash_before_checkout != $(git -C "$REPO_DEST" rev-parse HEAD) ]]; then
		sudo make clean distclean
		build_nvim
	else
		verbose "Commit unchanged. Skipping build."
	fi
else
	source "$RIBYN_ROOT/lib/run_on_distro.sh"

	run_on_arch <<'EOF'
	verbose "Detected Arch Linux. Installing dependencies..."
	sudo pacman -S --noconfirm --needed base-devel cmake unzip ninja curl
EOF

	run_on_fedora <<'EOF'
	verbose "Detected Fedora. Installing dependencies..."
	sudo dnf -y install ninja-build cmake gcc make unzip gettext curl
EOF

	info "Cloning Neovim repository..."
	git clone --depth 1 --no-single-branch "https://github.com/neovim/neovim" "$REPO_DEST"
	cd "$REPO_DEST" || exit 1
	git checkout "$GIT_REF"
	build_nvim
fi

success "Neovim installation complete."
