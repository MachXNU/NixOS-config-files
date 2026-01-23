{ ... }:

{
  clock = {
    format = "{:%I:%M %p}";
    format-alt = "{:%a, %d. %b}";
  };

  "custom/launcher" = {
    format = "󱄅";
    on-click = "wofi --show drun";
  };
}

