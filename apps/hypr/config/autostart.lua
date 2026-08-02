-- https://wiki.hypr.land/Configuring/Basics/Autostart/
local m = {}

local function default_autostart()
  -- Daemons
  hl.exec_cmd("mpd") -- uses daemon by default otherwise --no-daemon or --systemd
  -- rofi does not use daemons

  -- apps
  hl.exec_cmd("kitty", { workspace = 1 })
end

function m.setup()
  local ok, _local = pcall(require, "local.autostart")

  if ok and _local.enabled == true then
    _local.setup()
  else
    hl.on("hyprland.start", default_autostart)
  end
end
return m
