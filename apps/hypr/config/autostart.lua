-- https://wiki.hypr.land/Configuring/Basics/Autostart/
local m = {}

local function default_autostart()
  -- Daemons
  hl.exec_cmd("mpd") -- uses daemon by default otherwise --no-daemon or --systemd
  hl.exec_cmd("wob_volume listen")
  -- rofi does not use daemons

  -- apps
  hl.exec_cmd("kitty", { workspace = 1 })
end

function m.setup()
  local ok, _local = pcall(require, "local.autostart")

  if ok and _local.enabled == true then
    _local.setup()
    hl.on("hyprland.start", function()
      hl.config({
        decoration = {
          blur = {
            -- WARN: enabled in autostart, because in hyprland.lua it doesnt load correctly
            -- (I think its only the brightness which doesnt load correctly, looked like brightness 1)
            enabled = true,
            new_optimizations = true,
            -- use size 8, passes 1 for more performance or disable alltogehter
            size = 4,
            passes = 2,
            ignore_opacity = true,
            contrast = 1.2, -- sharpens the text slightly
            -- darken the blur 0.2 is really good. but I wanna see how high I can go without feeling troubled by reading
            brightness = 0.4, -- [0.0 - 2.0]
          },
        },
      })
    end)
  else
    hl.on("hyprland.start", default_autostart)
  end
end
return m
