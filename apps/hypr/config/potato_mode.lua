local m = {}

local function get_potato_mode()
  return os.getenv("RIBYN_HYPR_POTATO_MODE")
end

local function set_potato_mode(on_off)
  hl.env("RIBYN_HYPR_POTATO_MODE", on_off)
end

local function notify(on_off)
  -- affects animations, blur, shadow
  hl.notification.create({
    text = "potato mode: " .. on_off,
    timeout = 10000,
    icon = "info",
  })
end

function m.toggle()
  if get_potato_mode() == "on" then
    hl.config({
      animations = { enabled = false },
      decoration = {
        blur = { enabled = false },
        shadow = { enabled = false },
      },
    })

    set_potato_mode("off")
    notify("off")
  else
    require("animations").setup()
    require("decorations").setup()

    set_potato_mode("on")
    notify("on")
  end
end

function m.setup()
  local mode = get_potato_mode()
  if mode == nil or mode == "" then
    set_potato_mode("off")
  end
end
return m
