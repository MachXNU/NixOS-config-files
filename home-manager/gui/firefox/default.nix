{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;

    # IMPORTANT: new XDG layout (your choice)
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.user = {
      isDefault = true;

      settings = import ./profiles.nix;
    };

    policies = import ./preferences.nix {
      inherit pkgs;
      downloadDir = "${config.home.homeDirectory}/Downloads";
    };
  };
}
