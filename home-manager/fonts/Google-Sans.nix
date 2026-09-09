{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "google-sans";
  version = "1.0.0";

  src = ./assets/Google_Sans_Flex.zip;

  nativeBuildInputs = [
    pkgs.unzip
  ];

  unpackPhase = ''
    unzip "$src"
  '';

  installPhase = ''
    install -Dm644 static/GoogleSans-Regular.ttf \
      "$out/share/fonts/truetype/GoogleSans-Regular.ttf"

    install -Dm644 static/GoogleSans-Medium.ttf \
      "$out/share/fonts/truetype/GoogleSans-Medium.ttf"

    install -Dm644 static/GoogleSans-SemiBold.ttf \
      "$out/share/fonts/truetype/GoogleSans-SemiBold.ttf"

    install -Dm644 static/GoogleSans-Bold.ttf \
      "$out/share/fonts/truetype/GoogleSans-Bold.ttf"

    install -Dm644 static/GoogleSans-Italic.ttf \
      "$out/share/fonts/truetype/GoogleSans-Italic.ttf"

    install -Dm644 static/GoogleSans-MediumItalic.ttf \
      "$out/share/fonts/truetype/GoogleSans-MediumItalic.ttf"

    install -Dm644 static/GoogleSans-SemiBoldItalic.ttf \
      "$out/share/fonts/truetype/GoogleSans-SemiBoldItalic.ttf"

    install -Dm644 static/GoogleSans-BoldItalic.ttf \
      "$out/share/fonts/truetype/GoogleSans-BoldItalic.ttf"
  '';
}
