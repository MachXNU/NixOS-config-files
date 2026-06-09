{ pkgs, ... }:
let
  picoscopeIcon = pkgs.fetchurl {
    url = "https://avatars.githubusercontent.com/picotech";
    hash = "sha256-KufSAnI7GoXFt7PQk5C/JSYdyAuLkiktRbl+HNZwYMU=";
  };
in
{
  home.packages = [ pkgs.picoscope ];

  xdg.desktopEntries.picoscope = {
    name = "Picoscope";
    exec = "picoscope %u";
    icon = picoscopeIcon;
    terminal = false;
    type = "Application";
    categories = [ "Office" ];
  };
}
