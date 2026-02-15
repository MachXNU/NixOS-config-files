{ pkgs, ... }:

{
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
}
