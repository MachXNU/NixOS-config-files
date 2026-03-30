{ pkgs, lib, config, ... }:

{
  imports = [
    ./pywalfox-native.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
      extraPolicies = import ./preferences.nix { 
        inherit pkgs;
        downloadDirectory = "${config.home.homeDirectory}/Downloads";
      } ;
    };
    profiles = import ./profiles.nix { inherit pkgs lib; };
  };
}
