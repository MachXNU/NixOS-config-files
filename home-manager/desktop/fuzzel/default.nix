_:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        include = "~/.config/fuzzel/matugen-colors.ini";
        width = 45;
      };
      border = {
        radius = 15;
        selection-radius = 5;
      };
    };
  };
}
