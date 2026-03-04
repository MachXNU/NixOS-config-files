{
  description = "Hyperland on NixOS with Noctalia";

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
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    };
    material-theme = {
      url = "github:kuska1/Material-Theme";
      flake = false;
    };
    obsidian-nvim = {
      url = "github:epwalsh/obsidian.nvim";
      flake = false;
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
  let
    mkSystem = system: hostName: headless: hostsMicroVMs:
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs headless hostName hostsMicroVMs;
      };
      modules = [
        ./configuration.nix
        ./hosts/${hostName}/programs.nix
        ./hosts/${hostName}/hardware-configuration.nix
        inputs.agenix.nixosModules.default
        inputs.microvm.nixosModules.host

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jb = { ... }: {
              imports = [ 
                inputs.nvf.homeManagerModules.default
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
      nixos-vm  = mkSystem "aarch64-linux" "nixos-vm" true false;
      nixos-asustor  = mkSystem "x86_64-linux" "nixos-asustor" true true;
      nixos-laptop = mkSystem "x86_64-linux" "nixos-laptop" false false;
      nixos-brutuz = mkSystem "x86_64-linux" "nixos-brutuz" false false;
      nixos-vivobook = mkSystem "x86_64-linux" "nixos-vivobook" false false;
    };
  };
}
