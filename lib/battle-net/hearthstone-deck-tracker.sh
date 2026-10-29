#!/usr/bin/env bash

source "$RIBYN_ROOT/lib/battle-net/env.sh"
appid="$BATTLENET_NON_STEAM_GAME_APPID"

EXE="$HOME/Gaming/Hearthstone Deck Tracker/Hearthstone Deck Tracker.exe"

# if ! pgrep -f 'MonsterHunterWilds.exe' >/dev/null 2>&1; then
# 	echo "Start Monster Hunter Wilds from Steam first, then run this script." >&2
# 	exit 1
# fi

exec env \
	DOTNET_ROOT="C:\\Program Files\\dotnet" \
	DOTNET_ROOT_X64="C:\\Program Files\\dotnet" \
	protontricks-launch --appid "$appid" "$EXE"

# export DOTNET_ROOT="C:\\Program Files\\dotnet"
# export DOTNET_ROOT_64="C:\\Program Files\\dotnet"
# exec protontricks-launch --appid 2246340 "$HP"
