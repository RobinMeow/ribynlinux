#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/hypr/env.sh"
[[ "$RIBYN_HYPR_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"

source "$RIBYN_ROOT/core/run_on_distro.sh"
if ! on_fedora; then
	error "run hyribyn only on fedora."
	exit 1
fi

mkdir -p "$HOME/.local/state/ribyn/"
logfile="$HOME/.local/state/ribyn/install-hyribyn-fedora.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

info "installing hyribyn-fedora"

# this is where hyribyn will clone all the git repos,
# build, install and update them.
# hyribyn will also look in here for its own git location
# unless you set HYRIBYN
export HYRIBYN_ROOT="$HOME/.local/share/ribyn"

# hyribyn will be installed in ~/.local/share/ribyn/hyribyn
# will use HYRIBYN_ROOT if not set.
export HYRIBYN="$HOME/.local/share/ribyn/hyribyn"

SOURCERER_DEST="$HYRIBYN_ROOT" source "$RIBYN_ROOT/core/sourcerer.sh"

function hyribyn_installed() {
	# never consider it to be installed.
	# hyribyn is already idempotent and knows what it needs to run what not.
	return 0
}

function hyribyn_build_and_install() {
	# use fedora as target distro
	export HYRIBYN_DISTRO="fedora"

	# install all hyprland dependencies, hyprland itself,
	# and hyprland runtime dependencies
	"$HYRIBYN/hyprland/install-stack.sh"
	"$HYRIBYN/common/install-app.sh" "hyprlock"
	"$HYRIBYN/common/install-app.sh" "hyprmoncfg"
	"$HYRIBYN/common/install-app.sh" "hyprpaper"
	"$HYRIBYN/common/install-app.sh" "hyprpicker"
	"$HYRIBYN/common/install-app.sh" "hyprpolkitagent"
	"$HYRIBYN/common/install-app.sh" "hyprshutdown"

	if [[ "$RIBYN_HYPR_HY3_ENABLED" == "yes" ]]; then
		"$HYRIBYN/common/install-app.sh" "hy3"
	fi
}

check_source_state \
	"hyribyn" \
	"$RIBYN_HYRIBYN_GITREV"

source_git "https://github.com/RobinMeow/hyribyn.git"
