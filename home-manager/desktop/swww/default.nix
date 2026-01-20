{ pkgs, config, ... }:

let
  wallpaper = ../Wallpapers/minimalist-blue-mountains_8001x4501.jpg; 
in
{
  # swww daemon 
  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      RestartSec = 2;

      Environment = [
        "XDG_RUNTIME_DIR=%t"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # swww client, set wallpaper
  home.file."wallpapers/nord.png".source = wallpaper;

  systemd.user.services.swww-set-wallpaper = {
    Unit = {
      Description = "Set wallpaper via swww";
      After = [ "swww.service" ];
      Requires = [ "swww.service" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.swww}/bin/swww img \
          ${config.home.homeDirectory}/wallpapers/nord.png \
          --transition-type grow \
          --transition-duration 1
      '';
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
