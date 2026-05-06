{ inputs, ... }:

{
  perSystem = { pkgs, system, inputs', ... }: {
    packages = {
      firefox =
        import ../home-manager/gui/firefox/package.nix {
          inherit pkgs;
        };
    };
  };
}