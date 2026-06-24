local menu = "noctalia-shell ipc call launcher toggle"
local mod = "SUPER"

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")

package.path = package.path ..
    ";" .. os.getenv("HOME") .. "/.config/hypr/noctalia/?.lua"

require("noctalia-colors")

hl.config({
    general = {
        allow_tearing = false,
        border_size = 2,
        gaps_in = 4,
        gaps_out = 8,
        layout = "dwindle",
        resize_on_border = false,
        snap = {
          enabled = true,
        },
    },
    decoration = {
        active_opacity = 1.000000,
        blur = {
            enabled = true,
            passes = 3,
            size = 6,
            vibrancy = 0.169600,
        },
        dim_inactive = true,
        dim_special = 0.070000,
        dim_strength = 0.025000,
        inactive_opacity = 0.850000,
        rounding = 12,
        rounding_power = 2,
        shadow = {
            color = "rgba(000000ff)",
            enabled = true,
            offset = "0 2",
            range = 30,
            render_power = 4,
        },
    },
    input = {
        float_switch_override_focus = false,
        follow_mouse = true,
        kb_layout = "us",
        left_handed = false,
        natural_scroll = true,
        numlock_by_default = true,
        repeat_delay = 300,
        repeat_rate = 50,
        sensitivity = 0,
        touchpad = {
            clickfinger_behavior = true,
            disable_while_typing = true,
            drag_lock = true,
            middle_button_emulation = true,
            natural_scroll = true,
            tap_to_click = false,
        },
    },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
    animations = {
        enabled = true;
    },
})

hl.layer_rule ({
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.300000,
    match = { namespace = "noctalia-background-.*" },
    name = "noctalia",
})

hl.window_rule ({
    border_size = 0,
    center = true,
    dim_around = true,
    float = true,
    focus_on_activate = true,
    match = { class = "^(waypaper)$" },
    name = "waypaper-launcher",
    size = "1320 800",
    stay_focused = true,
})

hl.monitor({ output = "desc:BOE 0x093E", mode = "1920x1080@60", position = "0x0" })
hl.monitor({ output = "desc:BNQ BenQ EX2710Q C1R00852019", mode = "2560x1440@144", position = "1920x-1080" })
hl.monitor({ output = "desc:Philips Consumer Electronics Company PHL 243V7 UHB1720022390", mode = "1920x1080@60", position = "1920x0" })
hl.monitor({ output = "desc:Philips Consumer Electronics Company PHL 243V7 UHB1720023672", mode = "1920x1080@60", position = "3840x0" })
hl.monitor({ output = "desc:LG Electronics BK550Y 004NTDVGZ354", mode = "1920x1080@60", position = "1920x0" })
hl.monitor({ output = "desc:LG Electronics BK550Y 301MAPNG9616", mode = "1920x1080@60", position = "3840x0" })

hl.bind("SUPER + Q", function()
    hl.exec_cmd("kitty")
end)
hl.bind("SUPER + C", killactive())
hl.bind("SUPER + M", function()
    hl.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
end)
hl.bind("SUPER + E", function()
    hl.exec_cmd("$fileManager")
end)
hl.bind("SUPER + V", hl.dsp.togglefloating())
hl.bind("SUPER + D", function()
    hl.exec_cmd("noctalia-shell ipc call launcher toggle")
end)
hl.bind("SUPER + L", function()
    hl.exec_cmd("hyprlock")
end)
hl.bind("SUPER SHIFT + L", function()
    hl.exec_cmd("hyprlock & (loginctl lock-session && sleep 0.5 && systemctl suspend)")
end)
hl.bind("SUPER + W", function()
    hl.exec_cmd("waypaper --config-file $HOME/.config/waypaper/config.ini")
end)
hl.bind("SUPER + R", function()
    hl.exec_cmd("pkill -USR1 gpu-screen-rec")
end)
hl.bind("SUPER + left", hl.dsp.movefocus({ l }))
hl.bind("SUPER + right", hl.dsp.movefocus({ r }))
hl.bind("SUPER + up", hl.dsp.movefocus({ u }))
hl.bind("SUPER + down", hl.dsp.movefocus({ d }))
hl.bind("CTRL ALT + Delete", function()
    hl.exec_cmd("hyprctl dispatch exit 0")
end)
hl.bind(" + XF86MonBrightnessDown", function()
    hl.exec_cmd("noctalia-shell ipc call brightness decrease")
end)
hl.bind(" + XF86MonBrightnessUp", function()
    hl.exec_cmd("noctalia-shell ipc call brightness increase")
end)
hl.bind(" + XF86AudioRaiseVolume", function()
    hl.exec_cmd("noctalia-shell ipc call volume increase")
end)
hl.bind(" + XF86AudioLowerVolume", function()
    hl.exec_cmd("noctalia-shell ipc call volume decrease")
end)
hl.bind(" + XF86AudioMute", function()
    hl.exec_cmd("noctalia-shell ipc call volume muteOutput")
end)
hl.bind(" + XF86AudioPause", function()
    hl.exec_cmd("noctalia-shell ipc call media playPause")
end)
hl.bind(" + XF86AudioPlay", function()
    hl.exec_cmd("noctalia-shell ipc call media playPause")
end)
hl.bind(" + XF86AudioNext", function()
    hl.exec_cmd("noctalia-shell ipc call media next")
end)
hl.bind(" + XF86AudioPrev", function()
    hl.exec_cmd("noctalia-shell ipc call media previous")
end)
hl.bind("SUPER + code:10", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER SHIFT + code:10", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + code:11", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER SHIFT + code:11", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + code:12", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER SHIFT + code:12", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + code:13", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER SHIFT + code:13", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + code:14", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER SHIFT + code:14", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + code:15", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER SHIFT + code:15", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + code:16", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER SHIFT + code:16", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + code:17", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER SHIFT + code:17", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + code:18", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER SHIFT + code:18", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + mouse:272", hl.dsp.movewindow(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.resizewindow(), { mouse = true })

hl.on("hyprland.start", function()
    hl.exec_cmd("@dbusCmd@ --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
    hl.exec_cmd("noctalia-shell")
    hl.exec_cmd("@waypaper@ --restore --state-file $HOME/.config/waypaper/status")
end)

hl.curve("easeOutQuint", {
    type = "bezier",
    points = { {0.23, 1.0}, {0.32, 1.0} }
})
hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { {0.65, 0.05}, {0.36, 1.0} }
})
hl.curve("linear", {
    type = "bezier",
    points = { {0.0, 0.0}, {1.0, 1.0} }
})
hl.curve("almostLinear", {
    type = "bezier",
    points = { {0.5, 0.5}, {0.75, 1.0} }
})
hl.curve("quick", {
    type = "bezier",
    points = { {0.15, 0.0}, {0.1, 1.0} }
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10.0,
    curve = "default",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    curve = "easeOutQuint",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    curve = "easeOutQuint",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    curve = "easeOutQuint",
    style = "popin 87%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    curve = "linear",
    style = "popin 87%",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    curve = "almostLinear",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    curve = "almostLinear",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    curve = "quick",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    curve = "easeOutQuint",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4.0,
    curve = "easeOutQuint",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    curve = "linear",
    style = "fade",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    curve = "almostLinear",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    curve = "almostLinear",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.94,
    curve = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1.21,
    curve = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.94,
    curve = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "zoomFactor",
    enabled = true,
    speed = 7.0,
    curve = "quick",
})
