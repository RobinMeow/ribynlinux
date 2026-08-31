local m = {}
function m.setup()
  hl.config({
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
    general = {
      border_size = 2, -- size of the border around windows
      gaps_in = 10, -- gaps between windows (default: 5)
      gaps_out = 20, -- gaps between windows and montior edges (default: 20)

      col = {
        active_border = { -- active window border color
          colors = { -- gradient
            require("colors").primary,
            require("colors").secondary,
            -- require("colors").tertiary,
          },
          angle = 45,
        },
        inactive_border = require("colors").inactive, -- inactive window border color
      },

      -- use with care: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
      allow_tearing = false, -- used in gaming, for better latency

      -- set in environments.lua
      layout = require("hy3").enabled and "hy3" or "diwndle", -- "dwindle" "master" "scrolling" "monocle" (default: dwindle)
    },
  })
end
return m
