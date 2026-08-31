local m = {}

function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end
  return false
end
local can_enable = file_exists("/usr/lib/libhy3.so")

-- disabled for now. becuase either the plugin itself
-- or the plugin system from hyprland causes 3 reloads.
-- which are inaccaptable, because the layout is required
-- at startup time, not after, otherwise window spawning
-- will get messed up
m.enabled = false

function m.setup()
  if not m.enabled then
    return
  end

  hl.plugin.load("/usr/lib/libhy3.so")
  hl.config({
    plugin = {
      hy3 = {
        autotile = {
          enable = true,
        },
      },
    },
  })
end
return m
