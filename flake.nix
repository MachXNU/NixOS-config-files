{
    description = "Hyperland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jb = import ./users/jb/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
