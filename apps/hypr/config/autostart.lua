-- https://wiki.hypr.land/Configuring/Basics/Autostart/
local m = {}

local function default_autostart()
  -- daemons / jobs / etc.
  hl.exec_cmd("mpd") -- uses daemon by default otherwise --no-daemon or --systemd
  hl.exec_cmd("wob_volume listen")
  hl.exec_cmd("hyprpaper")
  -- rofi does not use daemons

  -- apps
  hl.exec_cmd("kitty", { workspace = "1" })
end

function m.setup()
  local ok, _local = pcall(require, "local.autostart")

  if ok and _local.enabled == true then
    hl.on("hyprland.start", function()
      -- set dark themes
      hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
      hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    end)
    _local.setup()
  else
    hl.on("hyprland.start", default_autostart)
  end
end
return m
