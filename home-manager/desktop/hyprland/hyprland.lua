-- ~/.config/hypr/hyprland.lua

----------------
-- VARIABLES  --
----------------

local mod = "SUPER"
local menu = "noctalia-shell ipc call launcher toggle"

----------------
-- SOURCES    --
----------------

hl.source("~/.config/hypr/noctalia/noctalia-colors.conf")

----------------
-- ENVIRONMENT --
----------------

hl.env("XDG_SESSION_TYPE,wayland")
hl.env("XCURSOR_THEME,Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE,24")

----------------
-- GENERAL     --
----------------

hl.general({
    gaps_in = 4,
    gaps_out = 8,

    border_size = 2,

    ["col.active_border"] = "$primary",
    ["col.inactive_border"] = "$surface",

    resize_on_border = false,
    allow_tearing = false,

    layout = "dwindle",

    snap = {
        enabled = true
    }
})

----------------
-- DECORATION  --
----------------

hl.decoration({
    rounding = 12,
    rounding_power = 2,

    active_opacity = 1.0,
    inactive_opacity = 0.85,

    blur = {
        enabled = true,
        size = 6,
        passes = 3,
        vibrancy = 0.1696
    },

    shadow = {
        enabled = true,
        ignore_window = true,
        range = 30,
        offset = "0 2",
        render_power = 4,
        color = "rgb(000000)"
    },

    dim_inactive = true,
    dim_strength = 0.025,
    dim_special = 0.07
})

----------------
-- INPUT       --
----------------

hl.input({
    kb_layout = "us",

    repeat_rate = 50,
    repeat_delay = 300,

    sensitivity = 0,

    numlock_by_default = true,
    left_handed = false,
    follow_mouse = true,
    float_switch_override_focus = false,

    natural_scroll = true,

    touchpad = {
        disable_while_typing = true,
        natural_scroll = true,

        clickfinger_behavior = true,
        middle_button_emulation = true,
        ["tap-to-click"] = false,
        drag_lock = true
    }
})

----------------
-- MISC        --
----------------

hl.misc({
    force_default_wallpaper = 0,
    disable_hyprland_logo = true
})

----------------
-- GROUPS      --
----------------

hl.group({
    ["col.border_active"] = "$tertiary",

    groupbar = {
        ["col.active"] = "$surface"
    }
})

----------------
-- LAYER RULES --
----------------

hl.layerrule({
    name = "noctalia",
    ["match:namespace"] = "noctalia-background-.*",

    ignore_alpha = 0.3,
    blur_popups = true,
    blur = true
})

----------------
-- WINDOWRULES --
----------------

hl.windowrule({
    name = "waypaper-launcher",

    ["match:class"] = "^(waypaper)$",

    float = true,
    size = "1320 800",
    center = true,
    border_size = 0,
    stay_focused = true,
    dim_around = true,
    focus_on_activate = true
})

----------------
-- MONITORS    --
----------------

hl.monitor(",2560x1440@144,auto,1")

----------------
-- ANIMATIONS  --
----------------

hl.bezier({
    name = "easeOutQuint",
    points = { 0.23, 1, 0.32, 1 }
})

hl.bezier({
    name = "easeInOutCubic",
    points = { 0.65, 0.05, 0.36, 1 }
})

hl.bezier({
    name = "linear",
    points = { 0, 0, 1, 1 }
})

hl.bezier({
    name = "almostLinear",
    points = { 0.5, 0.5, 0.75, 1 }
})

hl.bezier({
    name = "quick",
    points = { 0.15, 0, 0.1, 1 }
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default"
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint"
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint"
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%"
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%"
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick"
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade"
})

----------------
-- BINDS       --
----------------

hl.bind(mod .. ", Q, exec, kitty")
hl.bind(mod .. ", C, killactive")
hl.bind(mod .. ", V, togglefloating")

hl.bind(mod .. ", D, exec, " .. menu)

hl.bind(mod .. ", L, exec, hyprlock")

hl.bind(mod .. " SHIFT, L, exec, hyprlock & (loginctl lock-session && sleep 0.5 && systemctl suspend)")

hl.bind(mod .. ", left, movefocus, l")
hl.bind(mod .. ", right, movefocus, r")
hl.bind(mod .. ", up, movefocus, u")
hl.bind(mod .. ", down, movefocus, d")

hl.bind("CTRL ALT, Delete, exec, hyprctl dispatch exit 0")

----------------
-- WORKSPACES  --
----------------

for i = 1, 9 do
    hl.bind(mod .. ", code:1" .. (i - 1) .. ", workspace, " .. i)
    hl.bind(mod .. " SHIFT, code:1" .. (i - 1) .. ", movetoworkspace, " .. i)
end

----------------
-- MOUSE BINDS --
----------------

hl.bindm(mod .. ", mouse:272, movewindow")
hl.bindm(mod .. ", mouse:273, resizewindow")

----------------
-- AUTOSTART   --
----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")

    hl.exec_cmd(
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    )

    hl.exec_cmd(
        "waypaper --restore --state-file $HOME/.config/waypaper/status"
    )
end)

