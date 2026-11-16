-- Plugins are managed with hyprpm (see `hyprpm list`); run `hyprpm update` after Hyprland upgrades.
-- The block below is skipped while the plugin is not loaded.
if hl.plugin.dynamic_cursors then
    hl.config { plugin = { dynamic_cursors = {
        enabled = true,
        mode = "stretch",
    } } }
end
