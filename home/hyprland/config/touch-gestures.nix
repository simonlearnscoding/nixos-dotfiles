{...}: {
  wayland.windowManager.hyprland.settings.plugin.touch_gestures = {
    sensitivity = 1.0;
    workspace_swipe_fingers = 3;
    workspace_swipe_edge = "d";
    long_press_delay = 400;
    resize_on_border_long_press = true;
    edge_margin = 10;
    emulate_touchpad_swipe = false;

    experimental = {
      send_cancel = 0;
    };
  };

  # optional: additional gesture bindings
  wayland.windowManager.hyprland.settings."hyprgrass-bind" = [
    # swipe left from right edge → next workspace
    ", edge:r:l, workspace, +1"

    # swipe up from bottom → launch Firefox
    ", edge:d:u, exec, firefox"

    # 4-finger swipe down → kill active window
    ", swipe:4:d, killactive"
  ];
}
