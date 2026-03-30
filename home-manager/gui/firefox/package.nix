{ pkgs }:

pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
  extraPolicies = import ./preferences.nix {
    inherit pkgs;
    downloadDir = "$HOME/Downloads"; # fallback, should be safe of all UNIX systems
  };
}
