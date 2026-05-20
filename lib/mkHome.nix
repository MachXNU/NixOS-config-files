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
  pkgs = nixpkgs.legacyPackages.${system};
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
