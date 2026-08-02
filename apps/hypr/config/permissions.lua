-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/

local m = {}

function m.setup()
  -- WARN: permission changes require a Hyprland restart
  hl.config({
    ecosystem = {
      enforce_permissions = true,
    },
  })
  -- hl.permission({
  --   binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
  --   type = "screencopy",
  --   mode = "allow",
  -- })
  -- hl.permission({
  --   binary = "/usr/(bin|local/bin)/hyprpm",
  --   type = "plugin",
  --   mode = "allow",
  -- })
end

return m
