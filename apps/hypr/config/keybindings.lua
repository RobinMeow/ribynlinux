local m = {}

function m.setup()
  local key = require("key")
  -- Example binds https://wiki.hypr.land/Configuring/Basics/Binds/
  key.bind("SUPER + Q", hl.dsp.exec_cmd("kitty"), { desc = "open kitty terminal" })

  ---@diagnostic disable-next-line: unused-local
  local closeWindowBind = key.bind("SUPER + C", hl.dsp.window.close(), { desc = "close window" })
  -- closeWindowBind:set_enabled(false)

  key.bind(
    "SUPER + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
    { desc = "shutdown hyprland (cli cmd `hyprbye`)" }
  )
  key.bind("SUPER + E", hl.dsp.exec_cmd("kitty -e yazi"), { desc = "open explorer yazi" })

  -- https://wiki.hypr.land/Configuring/Basics/Dispatchers/#fullscreenstate
  -- TODO: make a selector thing, like internal,client combinations
  -- tho idk which the others could be useful fore
  key.bind(
    "SUPER + F",
    -- toggle fullscreen without toggleing the fullscreen of the inner app (streaming video)
    hl.dsp.window.fullscreen_state({ internal = 2, client = 0, mode = "fullscreen", action = "toggle" }),
    { desc = "toggle fullscreen" }
  )
  key.bind(
    "SUPER + SHIFT + F",
    -- toggle fullscreen within the inner app (didnt work as planned,
    -- but I can toggle this on, and than use vimium to click fullscreen to get my desired effect)
    hl.dsp.window.fullscreen_state({ internal = 0, client = 2, mode = "fullscreen", action = "toggle" }),
    { desc = "toggle fullscreen within inner app (e.g. in PWA)" }
  )

  -- NOTE: alternatives are hyprlauncher (just-works), anyrun (for powerusers: as in, run anything), fuzzel (for speed)
  key.bind(
    "SUPER + R",
    hl.dsp.exec_cmd('rofi -show drun -show-icons -icon-theme "Adwaita"'),
    { desc = "open rofi - desktop file launcher" }
  )
  key.bind(
    "SUPER + SHIFT + R",
    hl.dsp.exec_cmd('rofi -show window -show-icons -icon-theme "Adwaita"'),
    { desc = "open rofi - window switcher" }
  )

  key.bind("SUPER + V", hl.dsp.layout("togglesplit"), { desc = "toggle split (dwindle only)" })

  -- Move focus with SUPER + vim keys
  key.bind("SUPER + H", hl.dsp.focus({ direction = "left" }), { desc = "focus window: to the left" })
  key.bind("SUPER + J", hl.dsp.focus({ direction = "down" }), { desc = "focus window: downwards" })
  key.bind("SUPER + K", hl.dsp.focus({ direction = "up" }), { desc = "focus window: upwards" })
  key.bind("SUPER + L", hl.dsp.focus({ direction = "right" }), { desc = "focus window: to the right" })

  key.bind(
    "SUPER + SHIFT + H",
    hl.dsp.window.swap({ direction = "l" }),
    { desc = "swap window with window to the left" }
  )
  key.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }), { desc = "swap window with window below" })
  key.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }), { desc = "swap window with window above" })
  key.bind(
    "SUPER + SHIFT + L",
    hl.dsp.window.swap({ direction = "r" }),
    { desc = "swap window with window to the right" }
  )

  for i = 1, 10 do
    local digit = i % 10 -- 10 maps to key 0 (which is after 9 on most keyboards)
    hl.bind(
      "SUPER + " .. digit,
      hl.dsp.focus({ workspace = tostring(digit) }),
      { desc = "switch workspace to " .. digit }
    )
    hl.bind(
      "SUPER + SHIFT + " .. digit,
      hl.dsp.window.move({ workspace = tostring(digit) }),
      { desc = "move window to workspace " .. digit }
    )
  end
  local help = require("help")
  help.add("SUPER + [0-9]", "switch to workspace [0-9]")
  help.add("SUPER + SHFIT + [0-9]", "move window to workspace [0-9]")

  key.bind("SUPER + ALT + L", function()
    -- relative +1
    hl.dispatch(hl.dsp.workspace.move({ monitor = "+1" }))
  end, { desc = "move the workspace to the next monitor" })
  key.bind("SUPER + ALT + H", function()
    -- relative -1
    hl.dispatch(hl.dsp.workspace.move({ monitor = "-1" }))
  end, { desc = "move the workspace to the prev monitor" })

  -- special workspace (aka scratchpad)
  key.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"), { desc = "toggle special workspace" })
  key.bind(
    "SUPER + SHIFT + S",
    hl.dsp.window.move({ workspace = "special:magic" }),
    { desc = "move window to special workspace" }
  )

  key.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }), { desc = "focus next workspace" })
  -- TODO: conflicting with swicht keyboard layout
  key.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), { desc = "focus prev workspace" })

  -- NOTE: example for mouse keybind.
  -- Move windows with SUPER + LMB and dragging
  -- local LMB = "mouse:272" -- left mouse button
  -- key.bind("SUPER + " .. LMB, hl.dsp.window.drag(), { mouse = true })
  -- resize windows with SUPER + RMB and dragging
  -- local RMB = "mouse:273" -- right mouse button
  -- key.bind("SUPER + " .. RMB, hl.dsp.window.resize(), { mouse = true })

  local step = 100
  key.bind(
    "SUPER + SHIFT + left",
    hl.dsp.window.resize({ x = -step, y = 0, relative = true }),
    { desc = "relative resizing: left" }
  )
  key.bind(
    "SUPER + SHIFT + down",
    hl.dsp.window.resize({ x = 0, y = step, relative = true }),
    { desc = "relative resizing: down" }
  )
  key.bind(
    "SUPER + SHIFT + up",
    hl.dsp.window.resize({ x = 0, y = -step, relative = true }),
    { desc = "relative resizing: up" }
  )
  key.bind(
    "SUPER + SHIFT + right",
    hl.dsp.window.resize({ x = step, y = 0, relative = true }),
    { desc = "relative resizing: right" }
  )

  -- multimedia keys for volume and LCD brightness (usually on laptops for fn keys)
  -- NOTE: according to AI, locked is for allow in lock-screen and repeating for hold to spam
  key.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wob_volume up"),
    { locked = true, repeating = true, desc = "volume up +5%" }
  )
  key.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wob_volume down"),
    { locked = true, repeating = true, desc = "volume down -5%" }
  )
  key.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wob_volume mute"),
    { locked = true, repeating = true, desc = "mute volume" }
  )
  key.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true, desc = "mute microphone" }
  )
  key.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true, desc = "monitor brightness up +5%" }
  )
  key.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true, desc = "monitor brightness up -5%" }
  )
  key.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, desc = "media audio play" })
  key.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, desc = "media audio pause" })
  key.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, desc = "media audio next" })
  key.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, desc = "media audio prev" })

  key.bind("SUPER + P", require("potato_mode").toggle, { locked = true, desc = "toggle potato mode" })
  key.bind("SUPER + G", require("gaps").toggle, { locked = true, desc = "toggle gaps (padding/margins)" })

  key.bind(
    "Print",
    hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'),
    { desc = "screenshot with rectangular selection" }
  )

  key.bind("SUPER + PAUSE", hl.dsp.exec_cmd("wl-freeze -a"), { desc = "toggle wl-freeze the currently active window" })
end

return m
