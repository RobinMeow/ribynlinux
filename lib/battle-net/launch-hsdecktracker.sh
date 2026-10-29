# #!/usr/bin/env bash

source "$RIBYN_ROOT/lib/battle-net/env.sh"

appid="$BATTLENET_NON_STEAM_GAME_APPID"

exec protontricks-launch --appid "$appid" \
	"$HOME/.local/share/Steam/steamapps/compatdata/$appid/pfx/drive_c/users/steamuser/AppData/Local/HearthstoneDeckTracker/Hearthstone Deck Tracker.exe"
