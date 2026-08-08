local m = {}
function m.setup()
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
  })
end
return m
