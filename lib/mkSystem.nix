{
  inputs,
  nixpkgs,
  self,
}:
{
  system,
  hostName,
  username ? "jb",
  headless ? false,
  hostsMicroVMs ? false,
  runsVMs ? false,
}:
nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit
      inputs
      headless
      hostName
      hostsMicroVMs
      username
      ;
  };

  modules = [
    ../configuration.nix
    ../hosts/${hostName}/programs.nix
    ../hosts/${hostName}/hardware-configuration.nix
    inputs.agenix.nixosModules.default

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = false;

        users.${username}.imports = [
          inputs.nvf.homeManagerModules.default
          ../home-manager/home.nix
        ]
        ++ (if runsVMs then [ ../modules/home-manager/kvm.nix ] else [ ]);

        extraSpecialArgs = {
          inherit
            inputs
            headless
            hostName
            username
            runsVMs
            ;

          homeDirectory = "/home/${username}";
          isLinux = true;
          isWork = false;
          hyprlandConfig = toString ../hosts/${hostName}/hyprland.lua;
          hyprlockLayout = import ../hosts/${hostName}/hyprlock-layout.nix;
        };
      };
    }
  ]
  ++ (if hostsMicroVMs then [ inputs.microvm.nixosModules.host ] else [ ]);
}
