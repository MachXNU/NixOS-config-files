{ inputs, nixpkgs }:

{ system, hostName, headless ? false, hostsMicroVMs ? false }:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs headless hostName hostsMicroVMs;
  };

  modules = [
    ../configuration.nix
    ../hosts/${hostName}/programs.nix
    ../hosts/${hostName}/hardware-configuration.nix
    inputs.agenix.nixosModules.default

    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.jb = { ... }: {
          imports = [
            inputs.nvf.homeManagerModules.default
            ../home-manager/jb.nix
          ];
        };

        backupFileExtension = "backup";
        extraSpecialArgs = { inherit inputs headless; };
      };
    }
  ]
  ++ (if hostsMicroVMs then [ inputs.microvm.nixosModules.host ] else []);
}
