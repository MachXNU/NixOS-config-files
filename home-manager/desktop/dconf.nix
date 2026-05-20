{pkgs, ...}: {
  home.packages = with pkgs; [
    dconf
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/nm-applet" = {
        disable-connected-notifications = true;
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "adw-gtk3";
      };
    };
  };
}
