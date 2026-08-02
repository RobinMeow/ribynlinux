# Hyprland

[hyprland lua docs](https://alejandrominaya.github.io/hyprland-lua-docs/)

## Tasks

- [ ] brightness popups
- [ ] keybind toggle for performance (disable animations and blur)
- [ ] flameshot using bind or desktop file
- [ ] show workspace number in toolbar or somewhere (would fix the issue with needing a plugin/workspace viewer)
- [ ] time of day
- [ ] bluetooth open bluetui using a desktop file
- [ ] volume control
- [ ] disable mouse accel
- [ ] semi transparent / blurred background on all or just kitty windows
- [ ] prevent chrome from going into presentation mode when fullscreening
- [ ] make launchables for SUPER + E (oneshot gemini, google search, etc..)
- [ ] lock screen
- [ ] check if keyboard is configurable the same way for TTY to not depend on hyprland
- [ ] toggle margin/padding around windows and their border for space critical work
- [ ] keyboards inputs can be configured using comma seperations ai was lying
- [ ] set qwertz to be the default and only apply qwerty to glove80
- [ ] try custom warp script

> has a built in [timer](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Expanding-functionality/#timers)

---

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
- [ ] check why hyprland want `Hyprland` to be executed in docs but `start-hyprland` after running `Hyprland`
> kde login by using `startplasma-wayland` (`x11 if needed`)
> hypr login by using `Hyprland` or `start-hyprland`

---

wallpaper engine:
swww hyprpaper

desktop notification thingies:
swaync, hyprpanel, mako

```lua
-- Warp the mouse to the bottom-right corner whenever the active window changes
hl.on("window.active", function(w)
    if w ~= nil then
        -- Corner index 1 represents the bottom-right corner
        hl.dispatch(hl.dsp.cursor.move_to_corner({ corner = 1 }))
    end
end)
```
