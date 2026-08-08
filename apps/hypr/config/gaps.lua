local m = {}

local function get_gaps()
  return os.getenv("RIBYN_HYPR_GAPS")
end

local function notify(on_off)
  hl.notification.create({
    text = "gaps: " .. on_off,
    timeout = 10000,
    icon = "info",
  })
end

local function set_gaps(on_off)
  hl.env("RIBYN_HYPR_GAPS", on_off)
end
local prev_decoration = {}

function m.toggle()
  if get_gaps() == "on" then
    prev_decoration.rounding = hl.get_config("decoration.rounding")
    prev_decoration.rounding_power = hl.get_config("decoration.rounding_power")
    hl.config({
      decoration = {
        rounding = 0,
        rounding_power = 0,
      },
      general = {
        border_size = 1, -- still want to see which window is being focused
        gaps_in = 0,
        gaps_out = 0,
      },
    })

    set_gaps("off")
    notify("off")
  else
    require("general").setup()
    hl.config({
      decoration = {
        rounding = prev_decoration.rounding,
        rounding_power = prev_decoration.rounding_power,
      },
    })
    set_gaps("on")
    notify("on")
  end
end

function m.setup()
  local mode = get_gaps()
  if mode == nil or mode == "" then
    set_gaps("on")
  end
end
return m
