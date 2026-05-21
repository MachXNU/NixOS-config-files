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
    "debian" = mkHome {
      system = "x86_64-linux";
      isWork = true;
      username = "jb";
      homeDirectory = "/home/jb";
      hyprlandConfig = import ../hosts/debian-work/hyprland.nix;
      hyprlockLayout = import ../hosts/debian-work/hyprlock-layout.nix;
    };

    "macbookpro" = mkHome {
      system = "aarch64-darwin";
      username = "jb";
      homeDirectory = "/Users/jb";
      isLinux = false;
    };
  };
}
