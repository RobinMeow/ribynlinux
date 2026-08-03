local m = {}

function m.setup()
  -- Example binds https://wiki.hypr.land/Configuring/Basics/Binds/
  hl.bind("SUPER + Q", hl.dsp.exec_cmd("kitty"))
  local closeWindowBind = hl.bind("SUPER + C", hl.dsp.window.close())
  -- closeWindowBind:set_enabled(false)
  hl.bind(
    "SUPER + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
  )
  hl.bind("SUPER + E", hl.dsp.exec_cmd("kitty -e yazi"))

  -- https://wiki.hypr.land/Configuring/Basics/Dispatchers/#fullscreenstate
  -- TODO: make a selector thing, like internal,client combinations
  -- tho idk which the others could be useful fore
  hl.bind(
    "SUPER + F",
    -- toggle fullscreen without toggleing the fullscreen of the inner app (streaming video)
    hl.dsp.window.fullscreen_state({ internal = 2, client = 0, mode = "fullscreen", action = "toggle" })
  )
  hl.bind(
    "SUPER + SHIFT + F",
    -- toggle fullscreen within the inner app (didnt work as planned,
    -- but I can toggle this on, and than use vimium to click fullscreen to get my desired effect)
    hl.dsp.window.fullscreen_state({ internal = 0, client = 2, mode = "fullscreen", action = "toggle" })
  )

  -- NOTE: alternatives are hyprlauncher (just-works), anyrun (for powerusers: as in, run anything), fuzzel (for speed)
  hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun")) -- launch desktop files
  hl.bind("SUPER + W", hl.dsp.exec_cmd("rofi -show window")) -- window switching

  -- TODO: probably remove, I do not see why I would ever use this
  -- hl.bind("SUPER + P", hl.dsp.window.pseudo())
  hl.bind("SUPER + V", hl.dsp.layout("togglesplit")) -- dwindle only

  -- Move focus with SUPER + vim keys
  hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
  hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
  hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
  hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

  hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
  hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
  hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
  hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

  -- Switch workspaces with SUPER + [0-9]
  -- Move active window to a workspace with SUPER + SHIFT + [0-9]
  for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0 (which is after 9 on most keyboards)
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  end

  hl.bind("SUPER + ALT + L", function()
    -- Move the active workspace to the next monitor (relative +1)
    hl.dispatch(hl.dsp.workspace.move({ monitor = "+1" }))
  end)
  hl.bind("SUPER + ALT + H", function()
    -- Move the active workspace to the prev monitor (relative +1)
    hl.dispatch(hl.dsp.workspace.move({ monitor = "-1" }))
  end)

  -- Example special workspace (scratchpad)
  hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
  hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

  -- Scroll through existing workspaces with SUPER + scroll
  hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
  hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

  -- Move windows with SUPER + LMB and dragging
  local LMB = "mouse:272" -- left mouse button
  hl.bind("SUPER + " .. LMB, hl.dsp.window.drag(), { mouse = true })
  -- resize windows with SUPER + RMB and dragging
  local RMB = "mouse:273" -- right mouse button
  hl.bind("SUPER + " .. RMB, hl.dsp.window.resize(), { mouse = true })

  -- multimedia keys for volume and LCD brightness (usually on laptops for fn keys)
  -- NOTE: according to AI, locked is for allow in lock-screen and repeating for hold to spam
  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wob_volume up"), { locked = true, repeating = true })
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wob_volume down"), { locked = true, repeating = true })
  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wob_volume mute"), { locked = true, repeating = true })
  hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
  )
  hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
  hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true }
  )
  hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
  hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
  hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
  hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
end

return m
