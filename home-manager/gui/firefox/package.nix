{ pkgs }:

pkgs.wrapFirefox pkgs.firefox-unwrapped {
  extraPolicies = import ./preferences.nix {
    inherit pkgs;
    downloadDir = "$HOME/Downloads"; # fallback, should be safe of all UNIX systems
  };
}
