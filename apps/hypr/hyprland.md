# Hyprland

[hyprland lua docs](https://alejandrominaya.github.io/hyprland-lua-docs/)

## Tasks

- [ ] use something else for desktop notifications

deferred:

- [ ] mpvpaper engine (using mp4 and others for wallpapers)
- [ ] wayscriber = EpicPen. Fortunatly I no longer use the mouse, but maybe...

abandoned i think:

- [ ] ~~only blur terminal, for performance~~
  had a discord discussion with the result, that I dont need to bother with it.
- [ ] ~~brightness notifications (im too lazy to do wob again)~~
  got it covered with waybar
- [ ] ~~mp4 video is now working on hyprland in chrome e.g. wl-freeze github page~~
  swapping to brave (chromium based and works), and firefox also works
- [ ] ~~keyboards inputs can be configured using comma seperations ai was lying~~
  my own solution is good enough and doesnt depend on this wierd a** syntax
  of using string for csv files
- [ ] ~~see if I can find better architecture to swap gaps/potate modes configs~~
  it is partial updates by default with the exception of animations being
  unloaded when disabled
- [ ] swappy/slurp/grim ~~desktop files~~ for fullscreen shots or non edit copy
  screenshots dont want to use desktop files for this => maybe a hyprpicker?
  or hypr-independend cli solution?
- [ ] ~~set qwertz to be the default and only apply qwerty to glove80~~
- [ ] ~~hyprglass~~ not sure if worth it. might requires gtk/qt or sth.
  could be visually pleasing.
- [ ] ~~check if hypr-dynamic-cursor can be useful~~
- [ ] ~~try custom warp script~~
  (tried it, but needs to target only window.active if keyboard driven)
- [ ] ~~file_chooser needs some rules to be focused and floating probably~~
- [ ] ~~bluetooth open bluetui using a desktop file~~

completed:

- [x] build from source for fedora: https://github.com/hyprwm/hyprland-guiutils
- [x] waybar should kill itself on lockscreen. remember it was running,
  and start backup after lock screen
- [x] wl-freeze
  (freezes a process so it no longer consumes resources. Can work as pause for game)
- [x] improve the gpu/cpu/mem lockscreen to not feeze up
- [x] lock screen
- [x] floating window with keybinds SUPER + (SHIFT) + ?
  (keybinds should go trough a custom fn)
- [x] toggle border radius rounding on gaps.toggle
- [x] toggle margin/padding around windows
- [x] move env to environments.lua
- [x] hyprmoncfg seems to be able to have a gui to setup monitors, could be useful
- [x] make launchables for SUPER + E (oneshot gemini, google search, etc..)
- [x] ~~desktop file for ~~disk usage, or zshrc alias
- [x] rename performance mode to potato mode
- [x] swappy/slurp/grim shouldn tneed to ask for permission
- [x] swappy/slurp/grim print screen keybind
- [x] keybind toggle for performance (disable animations and blur)
- [x] cp wallpapers onto home and use those as reference instead of using
  $RIBYN_ROOT in hyprpaper.conf
- [x] file picker / download destination chooser is not yet in darkmode,
  and is disgusting to use (cant show hidden files)
- [x] wallpaper hyprpaper
- [x] disable mouse accel
- [x] prevent chrome from going into presentation mode when fullscreening
- [x] semi transparent / blurred background on all or just kitty windows
- [x] configure keyboard layouts at tty level and alphanumeric runns like
  `kb denodeadkeyscapswapesc` to switch em
- [x] local keyboard setup
- [x] allow a local lua file to define default workspaces
- [x] nodeadkeys for qwertz
- [x] swap capslock as altnernative to qwertz
- [x] set device to prefer darkmode
- [x] replace all color rgbs with hexstrings
- [x] volume
- [x] follow cursor? should not be centered in the middle of the focused window

---

- [x] disable login sddm `sudo systemctl disable sddm.service`

> kde login by using `startplasma-wayland` (`startplasma-x11` if needed)
> hypr login by using `start-hyprland`

---

hyprland-session.target
xdg-desktop-portal requires a graphical session target or it refuses to start.
`systemctl --user edit --full --force hyprland-session.target`
to create the config file

---

> has a built in [timer](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Expanding-functionality/#timers)

> [enable blur only for specific windows](https://github.com/hyprwm/Hyprland/discussions/4169)
> for now I take the performance hit
