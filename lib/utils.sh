#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/catppuccin-colors.sh"

RED="${CATRED}"
ORANGE="${CATORANGE}"
GREEN="${CATGREEN}"
BLUE="${CATBLUE}"
PURPLE="${CATMAGENTA}"
NC="\033[0m" # No Color

error() {
	echo -e "${RED}[ERROR]${NC} $*"
}

warn() {
	echo -e "${ORANGE}[WARN]${NC} $*"
}

success() {
	echo -e "${GREEN}[SUCCESS]${NC} $*"
}

info() {
	echo -e "${BLUE}[INFO]${NC} $*"
}

confirm() {
	# * **`read`**: The built-in Bash command that waits for user keyboard input.
	# * **`-p "..."`**: Prints the prompt text to the screen without adding a newline, displaying the variable's value and the `[y/N]` choice.
	# * **`-r`**: Treats backslashes literally (raw mode), preventing them from acting as escape characters.
	local prompt="$1"
	# use printf so the terminal interprets the ANSI escape sequences
	printf "${PURPLE}%s [y/N]${NC} " "$prompt"
	read -r || true
	echo # Move to a new line

	[[ "${REPLY:-n}" =~ ^[Yy]$ ]]
}

# TODO: use rsync -rlpt instead
ribyn_rsync() {
	# --recursive, -r          recurse into directories
	# --links, -l              copy symlinks as symlinks
	# --perms, -p              preserve permissions
	# --times, -t              preserve modification times
	# --verbose, -v
	rsync \
		--recursive \
		--links \
		--perms \
		--times "$@"
}

press_any_to_continue() {
	# * **`read`**: The built-in command that waits for user keyboard input.
	# * **`-n 1` (Bash) / `-k 1` (Zsh)**: Waits for exactly 1 character (no Enter required).
	# * **`-s`**: Silent mode, prevents the pressed key from printing to the screen.
	# * **`-r`**: Treats backslashes literally (raw mode).
	local prompt="${1:-Press any key to continue...}"

	# use printf so the terminal interprets the ANSI escape sequences
	printf "${PURPLE}%s${NC} " "$prompt"

	# Check if running in Zsh or Bash to use the correct character-limit flag
	if [[ ${ZSH_VERSION:-"not zsh"} == "not zsh" ]]; then
		# assume bash
		read -n 1 -s -r || true
	else
		read -s -r -k 1 || true
	fi

	echo # Move to a new line so the next terminal output doesn't mash into the prompt
}

cargobin() {
	"$HOME/.cargo/bin/cargo-binstall" --disable-telemetry --no-confirm $1
}

exit_with_distro_not_supported_msg() {
	error "Distro is not supported."
	exit 1
}
