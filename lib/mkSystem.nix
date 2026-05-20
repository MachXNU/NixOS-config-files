{
  inputs,
  nixpkgs,
  self,
}: {
  system,
  hostName,
  username ? "jb",
  headless ? false,
  hostsMicroVMs ? false,
}:
nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs headless hostName hostsMicroVMs username;
  };

  modules =
    [
      ../configuration.nix
      ../hosts/${hostName}/programs.nix
      ../hosts/${hostName}/hardware-configuration.nix
      inputs.agenix.nixosModules.default

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${username} = {...}: {
            imports = [
              inputs.nvf.homeManagerModules.default
              ../home-manager/home.nix
            ];
          };

          backupFileExtension = "backup";
          extraSpecialArgs = {
            inherit inputs headless hostName;
            myPackages = self.packages.${system};
          };
        };
      }
    ]
    ++ (
      if hostsMicroVMs
      then [inputs.microvm.nixosModules.host]
      else []
    );
}
