{ pkgs, ... }: {

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$menu" = "noctalia-shell ipc call launcher toggle";
    bind =
      [
        # Many more can be added, see documentation and default config for examples

        # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
        "$mod, Q, exec, kitty"
        "$mod, C, killactive"
        "$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating"
        "$mod, D, exec, $menu"
        "$mod, P, pseudo, # dwindle"
        "$mod, J, togglesplit, # dwindle"
        "$mod, L, exec, hyprlock"
        "$mod SHIFT, L, exec, hyprlock & (loginctl lock-session && sleep 0.5 && systemctl suspend)"

        # Should not be needed: as we are using Nix, we are not supposed to
        #                       manually reload the config file.
        # "$mod SHIFT, R, exec, hyprctl reload"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Exit Hyprland with Ctrl Alt Del
        "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"

        # Brightness keys
        ", XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"
        ", XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"

        # Audio keys
        ", XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
        ", XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
        ", XF86AudioMute,        exec, noctalia-shell ipc call volume muteOutput"

        # Media keys
        ", XF86AudioPause, exec, noctalia-shell ipc call media playPause"
        ", XF86AudioPlay,  exec, noctalia-shell ipc call media playPause"
        ", XF86AudioNext,  exec, noctalia-shell ipc call media next"
        ", XF86AudioPrev, exec, noctalia-shell ipc call media previous"
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

    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
