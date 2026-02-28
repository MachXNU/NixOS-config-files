{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "SFProBold";
  version = "1.0";

  src = ./assets/SFProBold.otf;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 $src $out/share/fonts/opentype/SFProBold.otf

    runHook postInstall
  '';
}
