hl.config({
    misc = {
        col = {
            splash = CACHYLGREEN,
        },
        middle_click_paste = false,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 3,
        -- Let apps focus themselves when a notification is clicked (xdg-activation)
        focus_on_activate = true,
    },
    render = {
        -- Hyprland 0.57 switches the output to BT.2020 when a fullscreen client
        -- sends a color description; this keeps the HDMI signal stable.
        cm_auto_hdr = 0,
    },
    xwayland = {
        force_zero_scaling = true
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})
