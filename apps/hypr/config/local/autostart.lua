-- https://wiki.hypr.land/Configuring/Basics/Autostart/

local m = {}
m.enabled = false

local function autostart()
  -- Daemons
  hl.exec_cmd("mpd") -- uses daemon by default otherwise --no-daemon or --systemd
  hl.exec_cmd("wob_volume listen")

  -- workspace 1
  hl.exec_cmd("kitty", { workspace = 1 })

  -- workspace 2
  hl.exec_cmd('kitty sh -c "rmpc play && rmpc"', { workspace = 2 })
  hl.exec_cmd("discord", { workspace = 2 })

  -- workspace 3
  -- running google-chrome-stable without args is the same as opening the default
  -- WARN: --profile-directory is not documented by google but its the only thing which works
  local workspace_3_front_monitor = {
    workspace = 3,
    -- use the same value as in output in local_monitors
    -- monitor = "DP-1",
  }
  hl.exec_cmd('google-chrome-stable --profile-directory="Default"', workspace_3_front_monitor)
  hl.exec_cmd('google-chrome-stable --profile-directory="Profile 2"', workspace_3_front_monitor)

  -- NOTE: reloading the config, because hyprland hasnt loaded all window rules
  -- worked fine on my high end pc, but my (extremely fast tbh) laptop it required a reload
  -- hl.exec_cmd("sleep 1.5; hyprctl dismissnotify; hyprctl reload")
end

function m.setup()
  hl.on("hyprland.start", autostart)
end
return m

-- INFO: Find your profile path for google chrome
-- 1. Open Chrome normally using the profile you want to target.
-- 2. Type `chrome://version` into the address bar and press **Enter**.
-- 3. Look for the **Profile Path** line.
-- 4. Note the very last folder in that path (it will usually be `Default`, `Profile 1`, `Profile 2`, etc.). This is your exact profile directory name.
-- > They are usually located in "$HOME/.config/google-chrome/Default"
-- > They are usually located in "$HOME/.config/google-chrome/Profile 2"
-- > you can also find it using the filenamanger and look for the profile images
