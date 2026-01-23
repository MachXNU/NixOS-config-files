{ ... }:

{
  clock = {
    format = "{:%I:%M %p}";
    format-alt = "{:%a, %d. %b}";
  };

  pulseaudio = {
    format = "{volume}% {icon}";
    format-bluetooth = "{volume}% {icon}";
    format-muted = "";
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
}

