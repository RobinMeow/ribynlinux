local m = {}

local help_file = os.getenv("HOME") .. "/.config/hypr/keybindings_help.md"
local help_entries = {}

--- adds it to the generated markdown help file
function m.add(keys, desc)
  table.insert(help_entries, {
    keys = keys,
    desc = desc,
  })
end

local function generate_help_file()
  -- Recreate the file from scratch every time the config runs.
  local file, err = io.open(help_file, "w+")

  if not file then
    error("Could not open keybinding help file: " .. tostring(err))
  end

  file:write("# Hyprland Keybindings\n\n")

  file:write("| Key | Description |\n")
  file:write("| --- | --- |\n")

  for _, entry in ipairs(help_entries) do
    -- Escape markdown table characters.
    local keys = entry.keys:gsub("|", "\\|")
    local desc = entry.desc:gsub("|", "\\|")

    file:write("| `" .. keys .. "` | " .. desc .. " |\n")
  end

  file:close()
end

local is_open = false
function m.open()
  if is_open then
    hl.dispatch(hl.dsp.focus({ window = "class:keybindings_help" }))
    return
  end

  hl.dispatch(hl.dsp.exec_cmd("kitty --class=keybindings_help sh -c 'nvim " .. help_file .. "'"))
  -- hl.dispatch(hl.dsp.focus({ window = "class:keybindings_help" }))
  is_open = true
end

function m.setup()
  hl.window_rule({
    name = "keybindings-help",
    match = {
      class = "^keybindings_help$",
    },
    float = true,
    size = { "(monitor_w*0.4)", "(monitor_h*0.6)" },
    center = true,
  })

  hl.on("window.close", function(window)
    if window.class == "keybindings_help" then
      is_open = false
    end
  end)

  -- code: listens on the hardware key. so it doesnt matter if you press shift or not
  -- qwerty would send / without shift, and qwertz sends sharp s
  local key = require("key") -- be careful of bi-dicretional dep. ez to create inf loop
  key.bind("SUPER + code:61", m.open, { desc = "Open this keybinding help" }, "SUPER + ?")
  key.bind("SUPER + SHIFT + code:61", m.open, { desc = "Open this keybinding help" }, "SUPER + SHIFT + ?")
  generate_help_file()
end

return m
