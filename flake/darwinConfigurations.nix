{ inputs, self, ... }:

let
  mkDarwinSystem = import ../lib/mkDarwinSystem.nix {
    inherit inputs;
    #nixpkgs = inputs.nixpkgs;
  };
in
{
  flake.darwinConfigurations = {
    macbook-pro-m4 = mkDarwinSystem {
      system = "aarch64-darwin";
      hostName = "Jbs-MacBook-Pro-M4";
    };
  };
}
