local m = {}

function m.setup()
  local main_mod = "SUPER"

  -- Example binds https://wiki.hypr.land/Configuring/Basics/Binds/
  hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd("kitty"))
  local closeWindowBind = hl.bind(main_mod .. " + C", hl.dsp.window.close())
  -- closeWindowBind:set_enabled(false)
  hl.bind(
    main_mod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
  )
  hl.bind(main_mod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))

  -- https://wiki.hypr.land/Configuring/Basics/Dispatchers/#fullscreenstate
  -- TODO: make a selector thing, like internal,client combinations
  -- tho idk which the others could be useful fore
  hl.bind(
    main_mod .. " + F",
    -- toggle fullscreen without toggleing the fullscreen of the inner app (streaming video)
    hl.dsp.window.fullscreen_state({ internal = 2, client = 0, mode = "fullscreen", action = "toggle" })
  )
  hl.bind(
    main_mod .. " + SHIFT + F",
    -- toggle fullscreen within the inner app (didnt work as planned,
    -- but I can toggle this on, and than use vimium to click fullscreen to get my desired effect)
    hl.dsp.window.fullscreen_state({ internal = 0, client = 2, mode = "fullscreen", action = "toggle" })
  )

  -- NOTE: alternatives are hyprlauncher (just-works), anyrun (for powerusers: as in, run anything), fuzzel (for speed)
  hl.bind(main_mod .. " + R", hl.dsp.exec_cmd("rofi -show drun")) -- launch desktop files
  hl.bind(main_mod .. " + W", hl.dsp.exec_cmd("rofi -show window")) -- window switching

  -- TODO: probably remove, I do not see why I would ever use this
  -- hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
  -- TODO: nice one, but I probably want to get rid of hjkl bindings to use them instead of arrows to switch windows
  hl.bind(main_mod .. " + V", hl.dsp.layout("togglesplit")) -- dwindle only

  -- Move focus with main_mod + vim keys
  hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
  hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))
  hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
  hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))

  hl.bind(main_mod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
  hl.bind(main_mod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
  hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
  hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

  -- Switch workspaces with main_mod + [0-9]
  -- Move active window to a workspace with main_mod + SHIFT + [0-9]
  for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0 (which is after 9 on most keyboards)
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  end

  -- Example special workspace (scratchpad)
  hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
  hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

  -- Scroll through existing workspaces with main_mod + scroll
  hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
  hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

  -- Move windows with main_mod + LMB and dragging
  local LMB = "mouse:272" -- left mouse button
  hl.bind(main_mod .. " + " .. LMB, hl.dsp.window.drag(), { mouse = true })
  -- resize windows with main_mod + RMB and dragging
  local RMB = "mouse:273" -- right mouse button
  hl.bind(main_mod .. " + " .. RMB, hl.dsp.window.resize(), { mouse = true })

  -- multimedia keys for volume and LCD brightness (usually on laptops for fn keys)
  -- NOTE: according to AI, locked is for allow in lock-screen and repeating for hold to spam
  hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
  )
  hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
  )
  hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
  )
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
