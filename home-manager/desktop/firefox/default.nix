{ pkgs, lib, config, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
      extraPolicies = import ./preferences.nix { inherit config pkgs;} ;
    };
    profiles = import ./profiles.nix { inherit pkgs lib; };
  };
}
