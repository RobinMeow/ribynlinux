#!/usr/bin/env bash

# WARN: i do not think i should add this here
# set -euo pipefail

source "$RIBYN_ROOT/lib/battle-net/env.sh"

appid="$BATTLENET_NON_STEAM_GAME_APPID"

exec protontricks-launch --appid "$appid" \
	"$HOME/.local/share/Steam/steamapps/compatdata/$appid/pfx/drive_c/Program Files (x86)/Battle.net/Battle.net.exe"
