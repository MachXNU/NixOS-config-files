{
  inputs,
  self,
  ...
}: let
  mkHome = import ../lib/mkHome.nix {
    inherit inputs self;
    nixpkgs = inputs.nixpkgs;
  };
in {
  flake.homeConfigurations = {
    "ubuntu" = mkHome {
      system = "x86_64-linux";
      isWork = true;
      username = "jb";
      homeDirectory = "/home/jb";
      hyprlandConfig = import ../hosts/ubuntu-work/hyprland.nix;
      hyprlockLayout = import ../hosts/ubuntu-work/hyprlock-layout.nix;
    };

    "macbookpro" = mkHome {
      system = "aarch64-darwin";
      username = "jb";
      homeDirectory = "/Users/jb";
      isLinux = false;
    };
  };
}
