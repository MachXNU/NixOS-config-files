{ inputs, config, pkgs, lib, ... }:

let
  toml = pkgs.formats.toml {};
  kittyTemplate  = ./desktop/matugen/templates/kitty-colors.conf;
  hyprTemplate   = ./desktop/matugen/templates/hyprland-colors.conf;
  fuzzelTemplate = ./desktop/matugen/templates/fuzzel-colors.ini;
  waybarTemplate = ./desktop/matugen/templates/waybar-colors.css;
  gtk3Template   = ./desktop/matugen/templates/matugen-gtk3-colors.css;
  gtk4Template   = ./desktop/matugen/templates/matugen-gtk4-colors.css;
in
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    pavucontrol
    inputs.matugen.packages.${pkgs.system}.default
    networkmanagerapplet
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
 
  xdg.configFile."matugen/config.toml".source =
    toml.generate "config.toml" {
      config.mode = "light";

      templates.kitty = {
        input_path = kittyTemplate; 
        output_path =
          "${config.home.homeDirectory}/.config/kitty/themes/Matugen.conf";
          post_hook = "kill -SIGUSR1 $(pgrep kitty)";
      };

      templates.hypr = {
        input_path = hyprTemplate;
        output_path = 
          "${config.home.homeDirectory}/.config/hypr/matugen.conf";
        post_hook = "hyprctl reload";
      };

      templates.fuzzel = {
        input_path = fuzzelTemplate;
        output_path = 
          "${config.home.homeDirectory}/.config/fuzzel/matugen-colors.ini";
      };

      templates.waybar = {
        input_path = waybarTemplate;
        output_path = 
          "${config.home.homeDirectory}/.config/waybar/matugen-colors.css";
      };
      
      templates.gtk3 = {
        input_path = gtk3Template;
        output_path = 
          "${config.home.homeDirectory}/.config/gtk-3.0/gtk.css";
      };


      templates.gtk4 = {
        input_path = gtk4Template;
        output_path = 
          "${config.home.homeDirectory}/.config/gtk-4.0/gtk.css";
      };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice"; # or Bibata-Modern-Amber
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
