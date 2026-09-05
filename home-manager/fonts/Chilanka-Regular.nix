{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "Chilanka Latin";
  version = "1.0.0";

  src = ./assets/Chilanka-Regular.ttf;

  unpackPhase = ''
    runHook preUnpack
    # No need to unzip, just copy the .ttf file as-is
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 $src -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
