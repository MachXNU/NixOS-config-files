{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    oh-my-zsh = {
      enable = true;

      theme = "robbyrussell"; 

      plugins = [
        "git"
        "sudo"
        "history"
        "command-not-found"
      ];
    };

    shellAliases = {
      # update = "sudo nixos-rebuild switch";
      # less = "TERM=xterm-256color less";
    };
    history.size = 10000;
  };
}
