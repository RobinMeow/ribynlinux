-- https://wiki.hypr.land/Configuring/Start/

hl.notification.create({ text = "Hyprland Version: " .. hl.version(), timeout = 5000 })

require("monitors").setup()

---- ENVIRONMENT VARIABLES ----
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- TODO: should I move this to my zshrc?
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

require("permissions").setup()
require("autostart").setup()

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
  general = {
    border_size = 2, -- size of the border around windows
    gaps_in = 5, -- gaps between windows (default: 5)
    gaps_out = 20, -- gaps between windows and montior edges (default: 20)

    col = {
      active_border = { -- active window border color
        colors = { -- gradient
          require("colors").secondary,
          require("colors").primary,
        },
        angle = 45,
      },
      inactive_border = "#595959aa", -- inactive window border color
    },

    -- use with care: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    allow_tearing = false, -- used in gaming, for better latency

    layout = "dwindle", -- "dwindle" "master" "scrolling" "monocle" (default: dwindle)
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    rounding = 8, -- in css terms: border radius
    rounding_power = 2, -- level of detail. lower values are less round

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    blur = {
      enabled = true, -- (default: true)
      -- use size 8, passes 1 for more performance or disable alltogehter
      size = 4, -- (default: 8)
      passes = 2, -- amount of times to perform the blurring process (default: 1)
      ignore_opacity = true, -- should blur ignore window's opacity (default: true)
      new_optimizations = true, -- massive perf. improvements (default: true)
      noise = 0.0, -- noise dez nuts? (default: 0.0117) could be nice for old horror movie theme
      contrast = 1.2, -- sharpens the text slightly (allows me to use less blur) (default: 0.8916)
      brightness = 0.4, -- [0.0 - 2.0] (default: 1.0)
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
    shadow = { -- window shadows
      enabled = true,
      range = 4, -- size in layout pixel (default: 4)
      render_power = 3, -- falloff [1-4] high number is strong fallof (default: 3)
      color = require("colors").shadow, -- supports gradiant (alpha dictates shadows opcaity)
    },

    -- NOTE: you can do a vignette on windows with this https://wiki.hypr.land/Configuring/Basics/Variables/#glow
    -- glow = {
    --   enabled = true,
    --   range = 20,
    --   render_power = 0,
    --   color = "#000", -- supports gradiant (alpha dictates shadows opcaity)
    -- },
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
  animations = { enabled = true }, -- (default: true)

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
  -- see input.lua and local/input.lua
  -- input = {
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#touchdevice
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#virtualkeyboard
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#tablet
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#tablettool
  -- },

  -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
  dwindle = {
    -- if enabled, the split (side/top) will not change regardless of what happens to the container.
    preserve_split = true,
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
  misc = {
    disable_hyprland_logo = true, -- disables the next line
    force_default_wallpaper = 2, -- -1 is random, 2 is hypr_chan (I don't like 0 and 1)
    -- font_family = "Sans", -- global default font including debug/dps/notifications (default: Sans)
    vrr = 0, -- adaptive sync 0 = off, 1 = on, 2 = fullscreen only, 3 = fullscreen with `video` or `game` content type (default: 0)
    layers_hog_keyboard_focus = true, -- ensures mouse movement doesnt drop focus on apps like rofi (default: true)
    -- TODO: use this and call hyprctl reload in my sync script
    disable_autoreload = false, -- use hyprctl reload instead (default: false)
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
    -- WARN: leave off I will not notice any flickering. Otherwise remove the option.
    -- Then it will enable itself on nvidia cards.
    nvidia_anti_flicker = false,
  },

  render = {
    direct_scanout = 0, -- when enabled attempts to reduce lag when there is only one fullscreen app on a screen (e.g. game). It's recommended to set this to false if the fullscreen app shows graphical glitches. 0 = off, 1 = on, 2 = auto (on with content type ‘game’)
  },

  cursor = {
    inactive_timeout = 2000, -- hide cursor after 2s
    persistent_warps = true, -- remember mouse position per window
    -- default_monitor = , -- TODO: perhaps this is what allow me to set my default workspace
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

-- Default curves and animations, https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

require("input").setup()

require("keybindings").setup()

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
-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- setting opacity will do for the whole window (including text)
-- hl.window_rule({
--   match = { class = "google-chrome" },
--   -- active inactive fullscreen
--   opacity = "0.9 0.9",
-- })
