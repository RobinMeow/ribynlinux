-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
local m = {}
function m.setup()
  hl.env("GTK_THEME", "Adwaita:dark")
  hl.env("GTK2_RC_FILES", "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc")
  -- TODO: maybe move to /etc/environment for system-wide default
  -- https://wiki.hypr.land/hypr-ecosystem/user/hyprqt6engine/
  hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
  -- WARN: use override if qt6ct is not being picked up
  -- hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")

  hl.env("XCURSOR_SIZE", "32")
  hl.env("XCURSOR_THEME", "catppuccin-latte-mauve-cursors")

  hl.env("HYPRCURSOR_SIZE", "32")
  hl.env("HYPRCURSOR_THEME", "catppuccin-latte-mauve-cursors")

  -- prevents hyprland layer issue.
  -- where keyboard focus is only captured
  -- correctly after mouse movement.
  hl.env("WAYSCRIBER_FORCE_INLINE_TOOLBARS", "1")
end
return m
