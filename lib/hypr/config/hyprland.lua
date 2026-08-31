hl.notification.create({
  text = "Hyprland Version: " .. hl.version(),
  timeout = 10000,
  icon = "info",
})

require("environments").setup()

local function require_hyprmoncfg_if_it_exists()
  -- workaround, becuase hyprmoncfg prevents creating the file
  -- if it does not find exactly 'require("hyprmoncfg")' in
  -- the root hyprland.lua file
  require("hyprmoncfg")
end
local ok = pcall(require_hyprmoncfg_if_it_exists)
if not ok then
  require("monitors").setup()
end

require("permissions").setup()
require("autostart").setup()

require("general").setup()
require("gaps").setup()
require("hy3").setup()

-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  -- decoration = , -- see decorations.lua
  -- animations = , -- animations.lua
  -- input = , -- see input.lua and local/input.lua

  -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
  dwindle = {
    -- if enabled, the split (side/top) will not change regardless of what happens to the container.
    preserve_split = true,
    force_split = 2, -- 0 = split follows mouse, 1 = always split to the left, new = left or top, 2 = always split to the right, new = right or bottom (default: 0)
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
  misc = {
    disable_splash_rendering = true, -- disable the qoute at the bottom of the background
    disable_hyprland_logo = true, -- disables the next line
    force_default_wallpaper = 2, -- -1 is random, 2 is hypr_chan (I don't like 0 and 1)
    -- font_family = "Sans", -- global default font including debug/dps/notifications (default: Sans)
    vrr = 0, -- adaptive sync 0 = off, 1 = on, 2 = fullscreen only, 3 = fullscreen with `video` or `game` content type (default: 0)
    layers_hog_keyboard_focus = true, -- ensures mouse movement doesnt drop focus on apps like rofi (default: true)
    -- NOTE: my sync.sh calls hyprctl reload. and I still manually invoke it (prevents duplicated notifications, which run on each copied file)
    disable_autoreload = true, -- use hyprctl reload instead (default: false)
    focus_on_activate = false, -- whether or not to focus a window which requests focus on activate
    -- background_color = "#111", -- requires disable_hyperland_logo to be true
    on_focus_under_fullscreen = 2, -- another window requesting focus while in fullscreen/maximized. 0 - ignore focus request, 1 - requested window takes over, 2 - disable fullscreen/maximize (default: 2)
    initial_workspace_tracking = 1, -- if enabled, windows will focus the workspace they were invoked on. 0 = disabled, 1 = single-shot, 2 = persistent (default: 1)
    middle_click_paste = true, -- primary selection (default: true)
    render_unfocused_fps = 15, -- maximum fps for unfocused windows' in the background
    -- screencopy_force_8b = true, -- forces 8 bit screencopy (default: true)
    -- bell_sound = "default", -- path to custom wav/ogg system bell. "none" or an empty str mute it (default: default)
  },

  opengl = {
    -- WARN: I have no issues even with nvidia card. leaving it off.
    -- Probably the flickering issue I used to have (on KDE)
    -- gpu drivers fixed it
    nvidia_anti_flicker = false,
  },

  render = {
    direct_scanout = 0, -- when enabled attempts to reduce lag when there is only one fullscreen app on a screen (e.g. game). It's recommended to set this to false if the fullscreen app shows graphical glitches. 0 = off, 1 = on, 2 = auto (on with content type ‘game’)
  },

  cursor = {
    inactive_timeout = 2000, -- hide cursor after 2s
    persistent_warps = true, -- remember mouse position per window
    -- WARN: I solved it myself already. and I think my solution is better, becuase of chrome/discord use cases.
    -- see local/monitors.lua for examples, why default_monitor is probably not sufficient
    -- default_monitor = , -- the name of a default monitor for the cursor to be set to on startup (see hyprctl monitors for names)
    hide_on_key_press = true, -- hide cursor on keyboard presses until mouse moves again
    zoom_disable_aa = true, -- when enabled, things will be pixelated instead of blurry when zoomed
  },

  ecosystem = {
    no_donation_nag = true, -- disabled notification askig, once again for my support
    -- WARN: permission changes require a Hyprland restart. for security reasons :)
    enforce_permissions = true, -- apps have to request access (e.g. when discord/obs wants to record the screen for screensharing) (default: false)
  },

  debug = {
    -- overlay = true, -- shows actual fps per monitor (default: false)
    error_limit = 5, -- limits the number of displayed config file parsing errors (default: 5)
  },
})

require("decorations").setup()
require("animations").setup()
require("input").setup()
require("keybindings").setup()
require("potato_mode").setup()

---- WINDOWS AND WORKSPACES ----
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.window_rule({
  -- Ignore maximize requests from all apps.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

require("xwayland").setup()
require("help").setup()
