local m = {}

local function get_perf_mode()
  return os.getenv("RIBYN_HYPR_PERFORMANCE_MODE")
end

local function set_perf_mode(yes_no)
  hl.env("RIBYN_HYPR_PERFORMANCE_MODE", yes_no)
end

function m.toggle()
  if get_perf_mode() == "yes" then
    hl.config({
      animations = { enabled = false },
      decoration = {
        blur = { enabled = false },
        shadow = { enabled = false },
      },
    })

    set_perf_mode("no")
    hl.notification.create({
      text = "DISABLED: animations, blur, shadow",
      timeout = 10000,
      icon = "info",
    })
  else
    require("animations").setup()
    require("decorations").setup()

    set_perf_mode("yes")
    hl.notification.create({
      text = "ENABLED: animations, blur, shadow",
      timeout = 10000,
      icon = "info",
    })
  end
end

function m.setup()
  local mode = get_perf_mode()
  if mode == nil or mode == "" then
    set_perf_mode("no")
  end
end
return m
