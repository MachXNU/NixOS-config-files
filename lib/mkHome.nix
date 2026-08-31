{
  inputs,
  nixpkgs,
}:
{
  system,
  headless ? false,
  username,
  homeDirectory,
  isWork ? false,
  isLinux ? true,
  isAppleSilicon ? false,
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

  extraSpecialArgs = {
    inherit
      inputs
      headless
      username
      homeDirectory
      isWork
      isLinux
      isAppleSilicon
      hyprlandConfig
      hyprlockLayout
      ;
  };

  modules = [
    inputs.nvf.homeManagerModules.default
    inputs.stylix.homeModules.stylix
    ../home-manager/home.nix
  ]
  ++ (if runsVMs then [ ../modules/home-manager/kvm.nix ] else [ ]);
}
