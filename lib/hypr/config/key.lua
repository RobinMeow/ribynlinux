local m = {}

--- Binds a key and adds it to the generated markdown help file.
---@param keys string The key combination (e.g., "SUPER + T")
---@param dispatcher HL.Dispatcher|function The action to execute
---@param options? HL.BindOptions Optional bind settings
---@param alt_keys string|nil the key combination to display in the help. SUPER + ?. Useful when you use code:61 keybindings
---@return HL.Keybind
function m.bind(keys, dispatcher, options, alt_keys)
  options = options or {}

  local desc = options.description or options.desc or "-"

  require("help").add(alt_keys or keys, desc)

  return hl.bind(keys, dispatcher, options)
end

return m
