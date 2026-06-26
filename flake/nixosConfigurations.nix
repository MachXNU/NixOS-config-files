{ inputs, self, ... }:

let
  mkSystem = import ../lib/mkSystem.nix {
    inherit inputs self;
    nixpkgs = inputs.nixpkgs;
  };
  mkVMSystem = import ../lib/mkVMSystem.nix {
    inherit inputs self;
    nixpkgs = inputs.nixpkgs;
  };
in
{
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
    };

    nixos-laptop = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-laptop";
    };

    nixos-brutuz = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-brutuz";
      runsVMs = true;
    };

    nixos-vivobook = mkSystem {
      system = "x86_64-linux";
      hostName = "nixos-vivobook";
    };

    nixos-vm-garage = mkVMSystem {
      system = "x86_64-linux";
      hostName = "nixos-vm-garage";
    };
  };
}
