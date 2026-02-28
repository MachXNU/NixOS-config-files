{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "StretchPro";
  version = "1.0";

  src = ./assets/StretchPro.otf;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 $src $out/share/fonts/opentype/StretchPro.otf

    runHook postInstall
  '';
}
