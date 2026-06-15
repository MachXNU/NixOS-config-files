{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "MapleMono";
  version = "1.0";

  src = ./assets/MapleMono-TTF-patch.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
