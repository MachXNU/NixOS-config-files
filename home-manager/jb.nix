{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./gui
    ./cli
];
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
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
}
