{ inputs, nixpkgs, self }:

{ system, hostName }:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs hostName;
  };

  modules = [
    ../hosts/${hostName}/configuration.nix
    ../hosts/${hostName}/hardware-configuration.nix
    inputs.agenix.nixosModules.default
  ];
}
