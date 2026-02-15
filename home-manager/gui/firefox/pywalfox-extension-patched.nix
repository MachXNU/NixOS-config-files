{ pkgs }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "pywalfox-patched";
  version = "2.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "Frewacom";
    repo = "pywalfox";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-RfxZfHBil1tgF1bqkHpxjFGLK5x0h5e5wxttOueZJG0=";
  };

  yarnDeps = pkgs.fetchYarnDeps {
    yarnLock = "${finalAttrs.src}/yarn.lock";
    sha256 = "sha256-tegi3VzYPGejkQ30aGcgXVKZK3k0ntBt5J1kdP7FPho=";
  };

  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.fixup-yarn-lock
    pkgs.yarn
    pkgs.coreutils
  ];

  configurePhase = ''
    runHook preConfigure

    export HOME=$(mktemp -d)
    yarn config --offline set yarn-offline-mirror ${finalAttrs.yarnDeps}
    fixup-yarn-lock yarn.lock
    yarn install --offline --frozen-lockfile --ignore-platform --ignore-scripts --no-progress --non-interactive
    patchShebangs node_modules/

    export NEW_BG=0
    export NEW_BG_LIGHT=1
    export NEW_BG_EXTRA=2
    export NEW_ACCENT_PRIMARY=10
    export NEW_ACCENT_SECONDARY=12
    export NEW_TEXT=15
    export NEW_TEXT_FOCUS=15
    sed -i "/DEFAULT_PALETTE_TEMPLATE_LIGHT/,/};/{
    s/\(background:[[:space:]]*\)[0-9]\+/\1$NEW_BG/;
    s/\(backgroundLight:[[:space:]]*\)[0-9]\+/\1$NEW_BG_LIGHT/;
    s/\(backgroundExtra:[[:space:]]*\)[0-9]\+/\1$NEW_BG_EXTRA/;
    s/\(accentPrimary:[[:space:]]*\)[0-9]\+/\1$NEW_ACCENT_PRIMARY/;
    s/\(accentSecondary:[[:space:]]*\)[0-9]\+/\1$NEW_ACCENT_SECONDARY/;
    s/\(text:[[:space:]]*\)[0-9]\+/\1$NEW_TEXT/;
    s/\(textFocus:[[:space:]]*\)[0-9]\+/\1$NEW_TEXT_FOCUS/;
    }" src/config/default-themes.ts

    runHook postConfigure
  '';

  patchPhase = ''
  '';

  buildPhase = ''
    runHook preBuild

    export PATH="$PATH:$(pwd)/node_modules/.bin"
    which node
    $(pwd)/node_modules/.bin/run-s
    yarn --offline run build

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/debug
    cp src/config/default-themes.ts $out/debug/
    mv artifacts/pywalfox*.zip $out/pywalfox.xpi
  '';
})

