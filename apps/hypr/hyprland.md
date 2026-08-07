# Hyprland

[hyprland lua docs](https://alejandrominaya.github.io/hyprland-lua-docs/)
 f
## Tasks

- [ ] floating window with keybinds SUPER + (SHIFT) + ?
- [ ] add file logging
- [ ] swappy/slurp/grim desktop files for fullscreen shots or non edit copy screenshots
- [ ] show workspace number in toolbar or somewhere (would fix the issue with needing a plugin/workspace viewer)
- [ ] toggleable reserved space for waybar
- [ ] time of day (waybar)
- [ ] bluetooth open bluetui using a desktop file
- [ ] volume control
- [ ] make launchables for SUPER + E (oneshot gemini, google search, etc..)
- [ ] lock screen
- [ ] toggle margin/padding around windows and their border for space critical work
- [ ] keyboards inputs can be configured using comma seperations ai was lying
- [ ] set qwertz to be the default and only apply qwerty to glove80
- [ ] try custom warp script (tried it, but needs to target only window.active if keyboard driven)
- [ ] check if hypr-dynamic-cursor can be useful
- [ ] mpvpaper engine (using mp4 and others for wallpapers)
- [ ] brightness popups
- [ ] brightness in waybar
- [ ] hyprglass. could be visually pleasing.
- [ ] wayscriber = EpicPen. Fortunatly I no longer use the mouse, but maybe...
- [ ] wl-freeze (freezes a process so it no longer consumes resources. Can work as pause for game)
- [ ] hyprmoncfg seems to be able to have a gui to setup monitors, could be useful

> has a built in [timer](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Expanding-functionality/#timers)

---

- [x] swappy/slurp/grim print screen keybind
- [x] keybind toggle for performance (disable animations and blur)
- [x] cp wallpapers onto home and use those as reference instead of using $RIBYN_ROOT in hyprpaper.conf
- [x] wallpaper hyprpaper
- [x] disable mouse accel
- [x] prevent chrome from going into presentation mode when fullscreening
- [x] semi transparent / blurred background on all or just kitty windows
- [x] configure keyboard layouts at tty level and alphanumeric runns like `kb denodeadkeyscapswapesc` to switch em
- [x] local keyboard setup
- [x] allow a local lua file to define default workspaces
- [x] nodeadkeys for qwertz
- [x] swap capslock as altnernative to qwertz
- [x] set device to prefer darkmode
- [x] replace all color rgbs with hexstrings
- [x] volume 
- [x] cursor (follow cursor?) should not be centered in the middle of the focused window. yikes!

---

- [x] disable login sddm `sudo systemctl disable sddm.service`
> kde login by using `startplasma-wayland` (`startplasma-x11` if needed)
> hypr login by using `start-hyprland`

---

wallpaper engine:
swww hyprpaper

desktop notification thingies:
swaync, hyprpanel, mako

> enable blur only for specific windows https://github.com/hyprwm/Hyprland/discussions/4169
> for now I trust it only blurs windows which actually have transparent background

