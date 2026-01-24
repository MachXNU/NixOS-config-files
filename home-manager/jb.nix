{ inputs, config, pkgs, lib, ... }:

let
  toml = pkgs.formats.toml {};
  kittyTemplate = ./desktop/matugen/templates/kitty-colors.conf;
in
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    pavucontrol
    inputs.matugen.packages.${pkgs.system}.default
  ];

  imports = [
    ./gui
    ./cli
    ./fonts
    ./desktop
  ];

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;

    # Disable soon-to-be-removed implicit defaults
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519_github";
        identitiesOnly = true;
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
    };
    # profileExtra = ''
    #   if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    #     exec hyprland
    #   fi
    # '';
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      filetype plugin indent on
      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2
      set number
      set relativenumber
      set smartindent
      set showmatch
      set backspace=indent,eol,start
      syntax on
    '';
    viAlias = true;
    vimAlias = true;
  };

  programs.wofi.enable = true;
  
  xdg.configFile."matugen/config.toml".source =
    toml.generate "config.toml" {
      config.mode = "dark";

      templates.kitty = {
        input_path = kittyTemplate; 
        output_path =
          "${config.home.homeDirectory}/.config/kitty/colors.json";
      };
    };
}
