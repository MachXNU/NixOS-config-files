{
  lib,
  username,
  ...
}:
{
  imports = [
    ./common.nix
  ];

  users.users.${username} = {
    home = "/Users/${username}";
  };

  # Enable Touch ID with sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
