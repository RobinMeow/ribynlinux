#!/usr/bin/env bash

# NOTE: serves as an example. I use the battle net launcher instead.
# Otherwise I would have to log into my account for every game each time I launch it.
# Or at least this was the case for WoW.

# WARN: i do not think i should add this here
# set -euo pipefail

source "$RIBYN_ROOT/lib/battle-net/env.sh"

appid="$BATTLENET_NON_STEAM_GAME_APPID"

exec protontricks-launch --appid "$appid" \
	"$HOME/.local/share/Steam/steamapps/compatdata/$appid/pfx/drive_c/Program Files (x86)/World of Warcraft/_retail_/Wow.exe"
