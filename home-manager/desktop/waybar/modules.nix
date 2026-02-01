{ ... }:

{
  clock = {
    format = "{:%I:%M %p}";
    format-alt = "{:%I:%M %p - %a, %d %b %Y}";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "month";
      on-scroll = 1;
      mode-mon-col = 3;
      format = {
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
    };
    actions = {
      on-click-right= "mode";
    };
  };

  pulseaudio = {
    format = "{icon}";
    format-bluetooth = "{volume}% {icon}";
    format-muted = "";
    format-icons = {
      headphone = "";
      hands-free = "󰓃";
      headset = "";
      phone = "";
      phone-muted = "";
      default = [ "" "" "" ];
    };
    scroll-step = 5;
    on-click = "pavucontrol";
    tooltip = true;
    tooltip-format = "{desc} ({volume}%)";
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
    format-wifi = "{icon}";
    format-ethernet = "{icon}";
    format-disconnected = "󰲛"; # An empty format will hide the module.
    tooltip-format = "{ifname} via {gwaddr} 󰈀";
    tooltip-format-wifi = "{essid} ({signalStrength}%)";
    tooltip-format-ethernet = "{ifname} ({ipaddr}/{cidr})";
    tooltip-format-disconnected = "Disconnected";
    max-length = 50;
    interval = 1;
    on-click = "nm-connection-editor";

    format-icons = {
      wifi = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
      ethernet = "";
    };
  };

  "hyprland/workspaces" = {
    format = "{name}";
    on-click = "activate";
  };
}

