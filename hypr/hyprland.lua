-- CachyOS Hyprland Configuration

require("config.animations")
require("config.autostart")
require("config.colors")
require("config.decorations")
require("config.variables")
require("config.environment")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.plugins")
require("config.monitors")
require("config.windowrules")
require("config.workspaces")


-- Added by Hyprland Settings (Noctalia plugin): loads the file its panel writes.
-- Move it up if a later block here must win over the panel.
require("hyprland-settings")

-- HyprMod managed settings
require("hyprland-gui")

-- For Noctalia Color templates
require("noctalia").apply_theme()
