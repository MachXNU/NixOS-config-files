{ pkgs, ... }:

{
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
}
