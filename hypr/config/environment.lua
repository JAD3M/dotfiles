-- Environmental variables (for reference https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/)
-- if you use UWSM, define your variables in ~/.config/uwsm/env
-- if you don't use UWSM, define your variables here (e.g. hl.env("QT_QPA_PLATFORM", "wayland"))

-- if you have an NVIDIA GPU uncomment the following lines:

-- hl.env("GBM_BACKEND", "nvidia-drm") -- force GBM as a backend
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia") -- force GBM as a backend
-- hl.env("LIBVA_DRIVER_NAME", "nvidia") -- Hardware acceleration on NVIDIA GPUs
-- hl.env("__GL_GSYNC_ALLOWED", "1") -- Controls if G-Sync capable monitors should use Variable Refresh Rate (VRR)

-- Lee el tema del cursor que guarda el plugin de Noctalia en cursor.conf
local f = io.open(os.getenv("HOME") .. "/.config/hypr/cursor.conf", "r")
if f then
    for line in f:lines() do
        local k, v = line:match("^env%s*=%s*(XCURSOR_%u+)%s*,%s*(.-)%s*$")
        if k then hl.env(k, v) end
    end
    f:close()
end
