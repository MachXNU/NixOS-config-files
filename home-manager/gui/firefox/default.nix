{ pkgs, lib, config, myPackages, ... }:

let
  myFirefox = myPackages.firefox.overrideAttrs (oldAttrs: {
    passthru = oldAttrs.passthru // {
      extraPolicies = import ./preferences.nix {
        inherit pkgs;
        downloadDir = "${config.home.homeDirectory}/Downloads"; 
      };
    };
  });
in
{
  programs.firefox = {
    enable = true;
    package = myFirefox;
    profiles = import ./profiles.nix { inherit pkgs lib; };
  };
}
