#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

if command -v signal >/dev/null 2>&1; then
	info "signal already installed. skipping."
	exit 0
fi

# snippet from https://signal.org/download/linux/

mkdir -p "$HOME/.local/share/ribyn/signal/"
(
	cd "$HOME/.local/share/ribyn/signal/"
	# download signing key and signature
	curl -fsSL -O https://updates.signal.org/desktop/signal-desktop.AppImage.gpg
	curl -fsSL -O https://updates.signal.org/static/desktop/appimage.asc

	# changing default ~/.gnupg home to avoid future runs to have a successfull
	# run, using an outdated imported signature
	TMP_GNUPG="$(mktemp -d)"
	export GNUPGHOME="$TMP_GNUPG"
	# shellcheck disable=SC2064
	trap "rm -rf \"$TMP_GNUPG\"" EXIT
	# --batch fail if gpg requires intervation, like merging fingerprints
	gpg --batch --import appimage.asc
	fingerprint="4B16B7232DFAA439AD791002EF9F501F13EED94C"
	gpg --batch --list-keys "$fingerprint"

	# verify the gpg signature against the executable
	curl -fsSL -O https://updates.signal.org/desktop/signal-desktop.AppImage
	gpg --verify signal-desktop.AppImage.gpg signal-desktop.AppImage

	# The `gpg --verify` command will show the following output for a good signature:
	#   gpg: Signature made
	#   gpg: using RSA key 4B16B7232DFAA439AD791002EF9F501F13EED94C
	#   gpg: Good signature from "Signal Messenger, LLC "
	# You will also see a warning about trusted signatures for that key. This is normal
	# and expected unless you manually mark the key as ultimately trusted (e.g. using
	# the `gpg --edit-key` command).

	chmod +x signal-desktop.AppImage

	# you can now run signal like this:
	# $HOME/.local/share/ribyn/signal/signal-desktop.AppImage
)

mkdir -p "$HOME/.local/bin"
ln --symbolic "$HOME/.local/share/ribyn/signal/signal-desktop.AppImage" "$HOME/.local/bin/signal"
# you can now run signal like this:
# signal

# The AppImage auto updates which can be configured in settings.
# For more info and optional setup please visit the Signal Support site:
# https://support.signal.org/hc/articles/360008216551-Installing-Signal
