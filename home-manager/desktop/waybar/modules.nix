{ ... }:

{
  clock = {
    format = "{:%I:%M %p}";
    format-alt = "{:%a, %d. %b}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode =       "year";
      mode-mon-col = 3;
      weeks-pos    = "right";
      on-scroll    = 1;
      format = {
        months   = "<span color='#ffead3'><b>{}</b></span>";
        days     = "<span color='#ecc6d9'><b>{}</b></span>";
        weeks    = "<span color='#99ffdd'><b>W{}</b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        today    = "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
      actions = {
        on-click-right = "mode";
        on-scroll-up   = "shift_up";
        on-scroll-down = "shift_down";
      };
    };
  };

  pulseaudio = {
    format = "{volume}% {icon}";
    format-bluetooth = "{volume}% {icon}";
    format-muted = "";
    format-icons = {
      headphone = "";
      hands-free = "󰓃";
      headset = "";
      phone = "";
      phone-muted = "";
      default = [ "" "" ];
    };
    scroll-step = 1;
    on-click = "pavucontrol";
    ignored-sinks = [ "Easy Effects Sink" ];
  };

  battery = {
    interval = 60;
    format = "{capacity}% {icon}";
    format-charging = "{capacity}% ";
    format-icons = [ "" "" "" "" ""];
  };

  network = {
    interface = null;
    format = "{ifname}";
    format-wifi = "{essid} {icon}";
    format-ethernet = "{ipaddr}/{cidr} 󰈀";
    format-disconnected = "DOWN"; # An empty format will hide the module.
    tooltip-format = "{ifname} via {gwaddr} 󰈀";
    tooltip-format-wifi = "{essid} ({signalStrength}%) {icon}";
    tooltip-format-ethernet = "{ifname} 󰈀";
    tooltip-format-disconnected = "Disconnected";
    max-length = 50;

    format-icons = {
      wifi = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
      ethernet = "󰈀";
    };
  };

  "hyprland/workspaces" = {
    format = "{name}";
    on-click = "activate";
  };
}

