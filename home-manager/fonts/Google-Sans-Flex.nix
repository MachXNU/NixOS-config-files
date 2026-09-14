{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "google-sans-flex";
  version = "1.0.0";

  src = ./assets/Google_Sans_Flex.zip;

  nativeBuildInputs = [
    pkgs.unzip
  ];

  unpackPhase = ''
    unzip "$src"
  '';

  installPhase = ''
    install -Dm644 static/GoogleSansFlex_36pt-Thin.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-Thin.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-ExtraLight.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-ExtraLight.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-Light.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-Light.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-Regular.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-Regular.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-Medium.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-Medium.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-SemiBold.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-SemiBold.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-ExtraBold.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-ExtraBold.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-Bold.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-Bold.ttf"

    install -Dm644 static/GoogleSansFlex_36pt-Black.ttf \
      "$out/share/fonts/truetype/GoogleSansFlex_36pt-Black.ttf"

  '';
}
