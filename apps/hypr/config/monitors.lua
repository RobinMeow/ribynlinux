local m = {}

local function auto_detection()
  -- NOTE: possible pre-defined mode values
  -- preferred - use the display’s preferred size and refresh rate.
  -- highres - use the highest supported resolution.
  -- highrr - use the highest supported refresh rate.
  -- maxwidth - use the widest supported resolution.
  hl.monitor({
    output = "",
    mode = "highrr",
    position = "auto-right",
    scale = "1",
  })

  -- INFO: this is recommended by docs (I like mine more)
  --
  -- hl.monitor({
  --   output = "",
  --   mode = "preferred",
  --   position = "auto",
  --   scale = "auto",
  -- })
end

function m.setup()
  -- https://wiki.hypr.land/Configuring/Basics/Monitors/

  -- Try load machine-local monitor config (local_monitors.lua)
  local success, local_monitors = pcall(require, "local.monitors")
  local colors = require("colors")
  if success then
    if local_monitors.enabled == true then
      hl.notification.create({
        text = "Loaded local_monitors.lua",
        timeout = 5000,
        color = colors.info,
      })
      local_monitors.setup()
    else
      hl.notification.create({
        text = "local_monitors.lua is disabled — using auto detection",
        timeout = 5000,
        color = colors.info,
      })
      auto_detection()
    end
  else
    hl.notification.create({
      text = "No local_monitors.lua found — using auto detection",
      timeout = 5000,
      color = colors.info,
    })
    auto_detection()
  end
end
return m
