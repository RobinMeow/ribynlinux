#!/usr/bin/env bash
set -euo pipefail

export BATTLENET_NON_STEAM_GAME_APPID=${BATTLENET_NON_STEAM_GAME_APPID:?"non steam game app id for battle.net not set. export env BATTLENET_NON_STEAM_GAME_APPID in your local zshrc"}
