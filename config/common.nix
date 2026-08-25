{
  lib,
  config,
  pkgs,
  inputs,
  username,
  hostName,
  ...
}:
let
  lightScheme = "${pkgs.base24-schemes}/share/themes/catppuccin-latte.yaml";
  darkScheme = "${pkgs.base24-schemes}/share/themes/catppuccin-macchiato.yaml";
in
{
  options.my.unfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      extra-experimental-features = [
        "pipe-operators"
      ];
    };

    nixpkgs.config.allowUnfreePackages = [
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

    stylix = {
      enable = true;
      polarity = "light";
      autoEnable = true;
      base16Scheme = lightScheme;
      fonts = {
        monospace = {
          package = import ../home-manager/fonts/MapleMono.nix { inherit pkgs; };
          name = "Maple Mono";
        };
        sizes = {
          terminal = 15;
        };
      };
    };
  };
}
