{ inputs, ... }:

let
  mkDarwinSystem = import ../lib/mkDarwinSystem.nix {
    inherit inputs;
  };
in
{
  flake.darwinConfigurations = {
    Jbs-MacBook-Pro-M4 = mkDarwinSystem {
      system = "aarch64-darwin";
      hostName = "Jbs-MacBook-Pro-M4";
    };
  };
}
