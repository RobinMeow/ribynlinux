#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"

# NOTE: cargo already skips if already installed
#
# if command -v pastel >/dev/null 2>&1 && [ -x "$HOME/.cargo/bin/pastel" ]; then
# 	info "pastel already installed. skipping."
# 	exit 0
# fi

if on_arch; then
	cargo-binstall --disable-telemetry --no-confirm \
		pastel
elif on_fedora; then
	cargobin pastel
fi

# NOTE: removed in favor of binstall. to reenable create env.sh
#
# git clone --depth 1 https://github.com/sharkdp/pastel "$HOME/pastel"
# cargo install --path "$HOME/pastel"
