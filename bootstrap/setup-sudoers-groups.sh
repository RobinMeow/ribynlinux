#!/bin/bash
set -euo pipefail

# This script must be run as root.
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

DEST_FILE="/etc/sudoers.d/admin-groups"
TMP_FILE=$(mktemp)

echo "Creating sudoers configuration at $DEST_FILE..."

cat <<EOF >"$TMP_FILE"
# Allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL

# Allow members of group sudo to execute any command
%sudo ALL=(ALL:ALL) ALL
EOF

# The "visudo" safety check
if visudo -c -f "$TMP_FILE"; then
	mv "$TMP_FILE" "$DEST_FILE"
	chmod 440 "$DEST_FILE"
	chown root:root "$DEST_FILE"
	echo "Successfully created and configured $DEST_FILE"
else
	echo "Syntax error in sudoers configuration! Aborting to prevent lockout."
	rm -f "$TMP_FILE"
	exit 1
fi
