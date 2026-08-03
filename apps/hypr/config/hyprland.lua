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
  general = {
    gaps_in = 5,
    gaps_out = 20,

    border_size = 2,

    col = {
      -- TODO: disable word color highlights
      active_border = { colors = { require("colors").secondary, require("colors").primary }, angle = 45 },
      inactive_border = "#595959aa",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- before you turn this on: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    allow_tearing = false, -- used in gaming, for better latency

    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
    rounding_power = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = require("colors").shadow,
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    blur = {
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

  animations = {
    enabled = true,
  },

  -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
  dwindle = {
    -- if enabled, the split (side/top) will not change regardless of what happens to the container.
    preserve_split = true,
  },

  misc = {
    force_default_wallpaper = 2, -- 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false, -- true disables random hyprland logo / anime girl background
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
