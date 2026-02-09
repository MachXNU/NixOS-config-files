_: {

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      repeat_rate = 50;
      repeat_delay = 300;

      sensitivity = 0; #mouse sensitivity
      numlock_by_default = true;
      left_handed = false;
      follow_mouse = true;
      float_switch_override_focus = false;
      
      natural_scroll = true;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;

        # maps 1-2-3 fingers click to LMB, RMB and MMB
        clickfinger_behavior = true;
        middle_button_emulation = true;
        tap-to-click = false;
        drag_lock = true;
      };
    };
  };
}
