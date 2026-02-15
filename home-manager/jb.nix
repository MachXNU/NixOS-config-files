{ inputs, config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./desktop
    ./cli
    ./gui
    ./fonts
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
      "gitlab-student.centralesupelec.fr" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519_gitlabcs";
        identitiesOnly = true;
      };
    };
  }; 
}
