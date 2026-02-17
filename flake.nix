{
    description = "Hyperland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
  let
    mkSystem = system: hostName: headless:
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs headless;
      };
      modules = [
        ./configuration.nix
        ./hosts/${hostName}/programs.nix
        ./hosts/${hostName}/hardware-configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jb = { ... }: {
              imports = [ ./home-manager/jb.nix ];
            };
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs headless; };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      nixos-vm  = mkSystem "aarch64-linux" "nixos-vm" true;
      nixos-laptop = mkSystem "x86_64-linux" "nixos-laptop" false;
      nixos-brutuz = mkSystem "x86_64-linux" "nixos-brutuz" false;
    };
  };
}
