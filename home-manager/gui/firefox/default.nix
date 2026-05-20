{
  pkgs,
  lib,
  config,
  ...
}: let
  myFirefox = pkgs.firefox.overrideAttrs (oldAttrs: {
    passthru =
      oldAttrs.passthru
      // {
        extraPolicies = import ./preferences.nix {
          inherit pkgs;
          downloadDir = "$HOME/Downloads";
        };
      };
  });
in {
  programs.firefox = {
    enable = true;
    package = myFirefox;
    profiles = import ./profiles.nix {inherit pkgs lib;};
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
