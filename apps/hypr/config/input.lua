-- input keyboard layout (project wide searchable terms)

-- switchable keyboard layouts: https://wiki.hypr.land/Configuring/Basics/Binds/#switchable-keyboard-layouts
-- WARN: apparently the options field applies to all layouts, making it useless becuase I need nodeadkeys
-- only for qwertz and not for qwerty

local main_mod = "SUPER"
local current_layout = "" -- qwerty us by default, see setup()

-- pre-defined layouts
local us = "us"
local de_nodeadkeys = "de_nodeadkeys"
local de_nodeadkeys_swap_capslock_esc = "de_nodeadkeys_swap:capslock,esc"

local function notify(text)
  hl.notification.create({ text = text, timeout = 5000 })
end

local function apply_layout(layout_name)
  if layout_name == us then
    hl.config({
      input = {
        kb_layout = "us",
        kb_variant = "",
        kb_options = "",
        kb_model = "",
        kb_rules = "",
      },
    })
  elseif layout_name == de_nodeadkeys then
    hl.config({
      input = {
        kb_layout = "de",
        kb_variant = "nodeadkeys",
        kb_options = "",
        kb_model = "",
        kb_rules = "",
      },
    })
  elseif layout_name == de_nodeadkeys_swap_capslock_esc then
    hl.config({
      input = {
        kb_layout = "de",
        kb_variant = "nodeadkeys",
        kb_options = "caps:swapescape",
        kb_model = "",
        kb_rules = "",
      },
    })
  end
  current_layout = layout_name
  notify("keyboard layout: " .. layout_name)
end

local function get_next_layout()
  if current_layout == us then
    return de_nodeadkeys
  elseif current_layout == de_nodeadkeys then
    return de_nodeadkeys_swap_capslock_esc
  elseif current_layout == de_nodeadkeys_swap_capslock_esc then
    return us
  else
    -- fallback to avoid infinite loop
    return us
  end
end

local function apply_next_layout()
  apply_layout(get_next_layout())
end
hl.bind(main_mod .. " + SHIFT + TAB", apply_next_layout)

local function init(opts)
  local opts = opts or {}
  hl.config({
    input = {
      follow_mouse = 1,

      sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = true,
      },
    },
    cursor = {
      -- remember mouse position per window
      persistent_warps = true,
    },
  })

  apply_layout(opts.layout or us)

  hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
  })

  -- Example per-device config https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
  -- hl.device({
  --   name = "epic-mouse-v1",
  --   sensitivity = -0.5,
  -- })
end

local m = {}
function m.setup()
  local ok, _local = pcall(require, "local.input")

  if ok and _local.enabled == true then
    init(_local.opts)
  else
    init()
  end
end
return m
