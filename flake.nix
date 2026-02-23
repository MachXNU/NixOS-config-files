{
  description = "Hyperland on NixOS with Noctalia";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      # url = "github:noctalia-dev/noctalia-shell";
      url = "github:MachXNU/noctalia-shell?ref=2c24f2d3757f76433a4c4490a9e2e7122aaf4312";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    };
    obsidian-nvim = {
      url = "github:epwalsh/obsidian.nvim";
      flake = false;
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nvf, ... }: 
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
              imports = [ 
                nvf.homeManagerModules.default
                ./home-manager/jb.nix
              ];
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
