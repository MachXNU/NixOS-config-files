{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice"; # or Bibata-Modern-Amber
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
