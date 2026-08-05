local m = {}
function m.setup()
  hl.config({
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
  })
end
return m
