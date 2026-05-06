{ inputs, self, ... }:

let
  mkSystem = import ../lib/mkSystem.nix {
    inherit inputs self;
    nixpkgs = inputs.nixpkgs;
  };
  mkSimpleSystem = import ../lib/mkSimpleSystem.nix {
    inherit inputs self;
    nixpkgs = inputs.nixpkgs;
  };
in {
  flake.nixosConfigurations = {
    nixos-vm = mkSystem {
      system = "aarch64-linux";
      hostName = "nixos-vm";
      headless = true;
    };

    nixos-asustor = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-asustor";
      headless = true;
      hostsMicroVMs = true;
    };

    nixos-laptop = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-laptop";
    };

    nixos-brutuz = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-brutuz";
    };

    nixos-vivobook = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-vivobook";
    };

    nixos-vm-garage = mkSimpleSystem {
      system = "x86_64-linux";
      hostName = "nixos-vm-garage";
    };
  };
}
