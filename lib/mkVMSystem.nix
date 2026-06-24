{
  inputs,
  nixpkgs,
  self,
}:

{ system, hostName }:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs hostName;
  };

  modules = [
    ../hosts/${hostName}/configuration.nix
    ../modules/qcow2.nix
  ];
}
