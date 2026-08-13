{
  pkgs,
  config,
  isWork,
  ...
}:
{
  programs.firefox = {
    enable = true;

    # IMPORTANT: new XDG layout (your choice)
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.user = {
      isDefault = true;

      settings = import ./profiles.nix;

      extensions = {
        settings."FirefoxColor@mozilla.com".force = true;
      };
    };

    policies = import ./preferences.nix {
      inherit pkgs isWork;
      downloadDir = "${config.home.homeDirectory}/Downloads";
    };
  };

  stylix.targets.firefox = {
    enable = true;
    colorTheme.enable = true;
    profileNames = [ "user" ];
  };
}
