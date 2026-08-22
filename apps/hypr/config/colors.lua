local m = {}

-- they have nice pastel colors
-- https://creativebooster.net/blogs/colors/pastel-color-palettes

---@diagnostic disable: unused-local
local electric_purple = "#bf00ff"
local vibrant_rose = "#ff00a0"
local monokai_orange = "#fd971f"
local gruvbox_orange = "#fe8019"
local hypr_default_blue = "#33ccffee"
local hypr_default_cyan_green = "#00ff99ee"

-- fallen knight (hyprpicked)
-- "#C67E86"
-- "#9F6178"
-- few more picks on the rose colored flower
-- "#D27775"
-- "#F6B0BC"
-- "#F6A4B3" (active)
-- "#D47387"
-- "#B1555C"
-- "#B75760"
-- "#E98984"
local flower_rose = "#F6A4B3"
local cherry_blossom = "#9C3337"
local earth = "#865220"
local sunrise = "#CB7E28"
local silver_armor = "#C1B09D"
local chainmail = "#3D3D3C"

-- fallen knight (neon-version)
-- need bright colors for this one,
-- becuase they are primarily showing which window has focus on
local flower_rose_neon = "#FF2A55"
local cherry_blossom_neon = "#FF433C"
local earth_neon = "#FF5E00"
local sunrise_neon = "#FFAC00"
local silver_armor_neon = "#eeeeee"

m.primary = sunrise_neon
m.secondary = earth_neon
m.tertiary = flower_rose

m.shaow = "#ee1a1a1a"

m.inactive = chainmail

return m
