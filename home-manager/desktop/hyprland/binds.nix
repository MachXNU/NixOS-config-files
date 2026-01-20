_: {

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        # Many more can be added, see documentation and default config for examples

        # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
        "$mod, Q, exec, kitty"
        "$mod, C, killactive"
        "$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo, # dwindle"
        "$mod, J, togglesplit, # dwindle"

        # Should not be needed: as we are using Nix, we are not supposed to
        #                       manually reload the config file.
        # "$mod SHIFT, R, exec, hyprctl reload"

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
      9)
    );
  };
}
