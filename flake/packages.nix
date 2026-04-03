{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.firefox =
      import ../home-manager/gui/firefox/package.nix {
        inherit pkgs;
      };
  };
}
