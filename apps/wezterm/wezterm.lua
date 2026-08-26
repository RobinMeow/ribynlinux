local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = {}
local workspaces_ok, workspaces = pcall(require, "my-workspaces")

config.color_scheme = "Catppuccin Mocha" -- https://wezterm.org/colorschemes/c/index.html#catppuccin-macchiato
config.font = wezterm.font("CommitMono Nerd Font")
config.font_size = 16

-- using 4 padding instead of 0 because of teams
-- screen sharing red border covering text otherwise
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Windows/Wsl/Linux
-- ensure wezterm starts in wsl and cwd is correctly carried over to new panes/tabs
local running_on_windows = package.config:sub(1, 1) == "\\"
if running_on_windows then
  -- https://wezterm.org/config/lua/config/default_domain.html
  -- https://github.com/wezterm/wezterm/issues/2090
  local wsl_domains = wezterm.default_wsl_domains()

  for _, dom in ipairs(wsl_domains) do
    dom.default_cwd = "~"
  end

  config.wsl_domains = wsl_domains
  config.default_domain = "WSL:fedorai3"
end

local function bind_key(mods, key, action)
  config.keys = config.keys or {}
  table.insert(config.keys, { mods = mods, key = key, action = action })
end

-- background
local env_bg = os.getenv("RIBYN_WEZTERM_BG")
if env_bg == "transparent" then
  config.window_background_opacity = 0
elseif env_bg == "transparent-darkened" then
  config.colors = { background = "black" }
  config.window_background_opacity = 0.9
elseif env_bg == "solid" then
  config.colors = { background = "#161616" }
elseif env_bg == "fallen-knight" then
  local sep = package.config:sub(1, 1)
  config.window_background_image = wezterm.config_dir .. sep .. ".config" .. sep .. "wezterm" .. sep .. "wallpaper.png"
  config.window_background_image_hsb = { brightness = 0.025 }
end

bind_key(
  "CTRL|SHIFT",
  "f",
  wezterm.action_callback(function(window, pane)
    if env_bg ~= "transparent-darkened" then
      return
    end

    local overrides = window:get_config_overrides() or {}
    local sep = package.config:sub(1, 1)
    local wallpaper = wezterm.config_dir .. sep .. ".config" .. sep .. "wezterm" .. sep .. "wallpaper.png"

    if overrides.window_background_image then
      -- Switch back to darkened transparent
      overrides.window_background_image = nil
      overrides.window_background_image_hsb = nil
      overrides.colors = { background = "black" }
      overrides.window_background_opacity = 0.9
    else
      -- Switch to wallpaper
      overrides.colors = nil
      overrides.window_background_opacity = 1.0
      overrides.window_background_image = wallpaper
      overrides.window_background_image_hsb = { brightness = 0.025 }
    end

    window:set_config_overrides(overrides)
  end)
)

config.window_decorations = "INTEGRATED_BUTTONS" -- remove the window title-bar which includes minmizing, fullscreening, and closing

-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
  if mux then
    local _, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
    if workspaces_ok then
      workspaces.setup(window, pane)
    else
      wezterm.log_info("Workspaces not found in .config/wezterm/my-workspaces.lua")
    end
  end
end)

bind_key("CTRL|SHIFT", "LeftArrow", act.ActivateTabRelative(-1))
bind_key("CTRL|SHIFT", "RightArrow", act.ActivateTabRelative(1))

-- navigation
bind_key("CTRL|SHIFT", "h", act.ActivatePaneDirection("Left"))
bind_key("CTRL|SHIFT", "j", act.ActivatePaneDirection("Down"))
bind_key("CTRL|SHIFT", "k", act.ActivatePaneDirection("Up"))
bind_key("CTRL|SHIFT", "l", act.ActivatePaneDirection("Right"))

-- https://wezterm.org/config/keys.html#physical-vs-mapped-key-assignments
-- using phys maps to a physical key. meaning it works for qwerty and qwertz (on qwertz ctrl+shift would cause the minus key to make an underscore)
-- NOTE: using the phys doesnt solve any qwerty/qwertz issues. e.g. qwertz requires pressing AltGr to press Pipe, so I will fail regardless.
-- They dont work. I tried inversing them, but the behavior stays as Enter = horizontal and Backspace vert
bind_key("CTRL|SHIFT", "Backspace", act.SplitVertical({ domain = "CurrentPaneDomain" }))
bind_key("CTRL|SHIFT", "Enter", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))

bind_key("CTRL|SHIFT", "w", act.CloseCurrentTab({ confirm = false }))

-- resizing
-- Each arrow triggers resize mode when pressed after prefix
local function enter_resize_mode()
  return act.ActivateKeyTable({ name = "resize_pane", one_shot = false })
end
bind_key("CTRL|SHIFT", "r", enter_resize_mode())

config.key_tables = {
  resize_pane = {
    { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 2 }) },
    { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 2 }) },
    { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 2 }) },
    { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 2 }) },
    { key = "Escape", action = "PopKeyTable" }, -- exit resizing mode
  },
  -- do not try again to use key_tables in combination with set_config_overrides.
  -- https://github.com/wezterm/wezterm/issues/5318 wont-fix since 2024
}

return config
