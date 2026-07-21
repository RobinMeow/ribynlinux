#!/usr/bin/env bash

cat <<'EOF'
====================================================================
                    WEZTERM KEYBINDS GUIDE                          
====================================================================
Leader Key: CTRL + b (Timeout: 2000ms)

[ Background & Customization ]
  CTRL+b t          Toggle transparent background
  CTRL+b i          Cycle to the next wallpaper
  CTRL+b r          Apply a random wallpaper
  CTRL+b v          Cycle background mode (wallpapers / motions)
  CTRL+b z          Reload WezTerm wallpaper config
  CTRL+b m          Toggle custom window padding
  CTRL+SHIFT+K      Increase background brightness / opacity
  CTRL+SHIFT+J      Decrease background brightness / opacity

[ Tab Navigation ]
  CTRL+b c          Create a new tab
  CTRL+b p          Switch to previous tab
  CTRL+b n          Switch to next tab
  CTRL+b 1..9       Switch to tab 1 - 9

[ Pane Management ]
  CTRL+b %          Split pane horizontally
  CTRL+b "          Split pane vertically
  CTRL+b x          Close current pane (with confirmation)
  CTRL+b h          Focus pane LEFT
  CTRL+b j          Focus pane DOWN
  CTRL+b k          Focus pane UP
  CTRL+b l          Focus pane RIGHT

[ Pane Resizing Sub-Mode ]
  CTRL+b + [Arrow]  Enter Pane Resize Mode

  While in Resize Mode:
    LeftArrow       Resize 2 units Left
    DownArrow       Resize 2 units Down
    UpArrow         Resize 2 units Up
    RightArrow      Resize 2 units Right
    Escape          Exit Resize Mode

====================================================================
EOF
