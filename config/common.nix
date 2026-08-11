{
  lib,
  pkgs,
  inputs,
  hostName,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "obsidian"
      "davinci-resolve"
    ];

  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        nord-nvim = prev.vimUtils.buildVimPlugin {
          name = "nord-nvim";
          src = inputs.nord-nvim;
        };
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    git
    wireguard-tools
    home-manager
  ];

  networking.hostName = hostName;

  time.timeZone = "Europe/Amsterdam";

  environment.variables.EDITOR = "nvim";
}
