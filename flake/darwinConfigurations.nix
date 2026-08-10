{ inputs, self, ... }:

let
  mkDarwinSystem = import ../lib/mkDarwinSystem.nix {
    inherit inputs self;
    #nixpkgs = inputs.nixpkgs;
  };
in
{
  flake.darwinConfigurations = {
    macbook-pro-m4 = mkDarwinSystem {
      system = "aarch64-darwin";
      hostName = "MacBook Pro M4";
    };
  };
}
