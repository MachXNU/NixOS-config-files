_: {
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;

    # Disable soon-to-be-removed implicit defaults
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519_github";
        identitiesOnly = true;
      };
    };
  };
}
