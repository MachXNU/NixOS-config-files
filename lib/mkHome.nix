{
  inputs,
  nixpkgs,
  self,
}: {
  system,
  headless ? false,
  username,
  homeDirectory,
  isWork ? false,
  isLinux ? false,
  hyprlockLayout ? null,
}: let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
  inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit
        inputs
        headless
        username
        homeDirectory
        isWork
        isLinux
        hyprlockLayout
        ;
    };

    modules = [
      inputs.nvf.homeManagerModules.default
      ../home-manager/home.nix
    ];
  }
