{ lib, pkgs, ... }:

let
  light = ./wallpapers/light;
  dark = ./wallpapers/dark;

  waypaper = pkgs.writeShellScript "waypaper" ''
    mode="$(noctalia msg theme-mode-get)"

    case "$mode" in
      light) folder="${toString light}" ;;
      dark)  folder="${toString dark}" ;;
      *)     echo "Unknown Noctalia theme mode: $mode" >&2; exit 1 ;;
    esac

    exec ${pkgs.waypaper}/bin/waypaper --folder "$folder"
  '';
in
{
  home.packages = [
    pkgs.mpvpaper
  ];

  home.file.".local/bin/waypaper".source = waypaper;

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file.".config/waypaper/config.ini".text = lib.generators.toINI { } {
    Settings = {
      backend = "mpvpaper";
      language = "en";
      show_path_in_tooltip = true;
      fill = "fill";
      sort = "name";
      color = "#ffffff";
      subfolders = true;
      all_subfolders = true;
      show_hidden = false;
      show_gifs_only = false;
      zen_mode = true;
      post_command = "sed -i \"/background {/,/}/ s|^\\([[:space:]]*path=\\).*|\\1$(mpvpaper -p | head -n1)|\" ~/.config/hypr/hyprlock.conf && kill -9 $(pgrep waypaper)";
      number_of_columns = 2;
      mpvpaper_sound = false;
      mpvpaper_options = "--hwdec=auto-safe --profile=fast --no-audio --loop";
      use_xdg_state = true;
      folder = toString light;
      #stylesheet = "$HOME/.config/waypaper/style.css";
      #keybindings = "$HOME/.config/waypaper/keybindings.ini";
    };
  };
}
