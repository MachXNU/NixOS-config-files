{
  inputs,
  self,
  ...
}:
let
  mkHome = import ../lib/mkHome.nix {
    inherit inputs self;
    nixpkgs = inputs.nixpkgs;
  };
in
{
  flake.homeConfigurations = {
    "ubuntu" = mkHome {
      system = "x86_64-linux";
      isWork = true;
      username = "jbamade";
      homeDirectory = "/home/jbamade";
      hyprlandConfig = toString ../hosts/ubuntu-work/hyprland.lua;
      hyprlockLayout = import ../hosts/ubuntu-work/hyprlock-layout.nix;
      runsVMs = true;
    };

    "macbookpro" = mkHome {
      system = "aarch64-darwin";
      username = "jb";
      homeDirectory = "/Users/jb";
      isLinux = false;
    };
  };
}
