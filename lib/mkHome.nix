{
  inputs,
  nixpkgs,
  self,
}:
{
  system,
  headless ? false,
  username,
  homeDirectory,
  isWork ? false,
  isLinux ? true,
  hyprlandConfig ? null,
  hyprlockLayout ? null,
  runsVMs ? false,
}:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [
    inputs.nvf.homeManagerModules.default
    ../home-manager/home.nix
  ]
  ++ (if runsVMs then [ ../modules/home-manager/kvm.nix ] else [ ]);

  extraSpecialArgs = {
    inherit
      inputs
      headless
      username
      homeDirectory
      isWork
      isLinux
      hyprlandConfig
      hyprlockLayout
      runsVMs
      ;
  };
}
