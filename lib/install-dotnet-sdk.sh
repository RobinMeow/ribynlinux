#!/usr/bin/env bash
set -euo pipefail

echo "Usage: pass in the version with --version 10.0.3"
echo "INFO: for versions which read EOL (end of life) you have to specify the full exact verion."
echo "see here for out of support versions (expand the panel): https://dotnet.microsoft.com/en-us/download/dotnet"
echo "click on the major version, which then lists the sdk version (the latest release version on the prev page is sth else)"

# URL of the official Microsoft .NET install script
DOTNET_INSTALL_URL="https://dot.net/v1/dotnet-install.sh"

# create tmp file
TMP_SCRIPT="$(mktemp)"
# Ensure cleanup always runs
trap 'rm -f "$TMP_SCRIPT"' EXIT

echo "Downloading .NET install script..."
# Download the script to a temporary file
curl -fsSL "$DOTNET_INSTALL_URL" -o "$TMP_SCRIPT"

chmod +x "$TMP_SCRIPT"

echo "Running install script with arguments: $*"

# Execute the script, forwarding all arguments
"$TMP_SCRIPT" "$@"
