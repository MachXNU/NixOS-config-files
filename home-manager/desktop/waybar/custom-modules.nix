{ ... }:

{
   "custom/appmenu" = { 
    format = "󱄅";
    on-click = "fuzzel";
    tooltip = false;
  };

  "group/systemutils" = {
    orientation = "horizontal";
    modules = ["pulseaudio" "network" "battery"];
  };
}
