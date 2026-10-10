-- Input configuration

hl.config({
    input = {
        kb_layout = "latam",
        sensitivity = -0.1,
        accel_profile = "flat",
        touchpad = {
                natural_scroll = true,
                scroll_factor = 0.2,
                tap_to_click = true,
                tap_and_drag = true,
        },
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    cursor = {
        no_hardware_cursors = 1,
        enable_hyprcursor = false,
      },
})

-- Touchpad con aceleración tipo Windows
hl.device({
    name = "syna2ba6:00-06cb:cefe-touchpad",
    accel_profile = "adaptive",
    sensitivity = 0.2,
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
