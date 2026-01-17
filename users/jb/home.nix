{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";
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

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        name = "Jb";
        email = "42501418+MachXNU@users.noreply.github.com";
      };
    };
  };

  programs.neovim = {
  enable = true;
  extraConfig = ''
    filetype plugin indent on
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
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
