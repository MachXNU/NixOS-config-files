{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "SFProRegular";
  version = "1.0";

  src = ./assets/SFProRegular.otf;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 $src $out/share/fonts/opentype/SFProRegular.otf

    runHook postInstall
  '';
}
