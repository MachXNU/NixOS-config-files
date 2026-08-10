{
  inputs,
}:
{
  system,
  hostName,
  username ? "jb",
}:

inputs.nix-darwin.lib.darwinSystem {
  inherit system;

  specialArgs = {
    inherit
      inputs
      hostName
      username
      ;
  };

  modules = [
    ../config/darwin-configuration.nix

    # Host-specific config
    #../hosts/${hostName}/programs.nix

    inputs.agenix.darwinModules.default

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = false;

        users.${username} = {
          imports = [
            inputs.nvf.homeManagerModules.default
            ../home-manager/home.nix
          ];
        };

        backupFileExtension = "backup";

        extraSpecialArgs = {
          inherit
            inputs
            hostName
            username
            ;

          headless = false;

          homeDirectory = "/Users/${username}";
          isLinux = false;
          isWork = false;

          hyprlandConfig = null;
          hyprlockLayout = null;
        };
      };
    }
  ];
}
