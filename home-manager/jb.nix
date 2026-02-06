{ inputs, config, pkgs, lib, ... }:
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    pavucontrol
    inputs.matugen.packages.${pkgs.system}.default
    networkmanagerapplet
  ];

  imports = [
    # ./gui
    ./cli
    ./fonts
    ./desktop
    ./noctalia.nix
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
 
  home.pointerCursor = {
    name = "Bibata-Modern-Ice"; # or Bibata-Modern-Amber
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
