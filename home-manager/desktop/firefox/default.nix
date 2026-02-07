{ pkgs, lib, config, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped{
      extraPolicies = import ./preferences.nix { inherit config;} ;
    };
    profiles = import ./profiles.nix { inherit pkgs lib; };
  };
}
