{
  wayland.windowManager.hyprland.settings.decoration = {
    rounding = 8; # Slightly increased for smoother, rounded corners
    # shadow = {
    #   enabled = true;
    # };
    blur = {
      noise = 0.03; # Adjusted for a more refined blur texture
      size = 10; # Increased for a smoother and more intense blur effect
      passes = 3;
      vibrancy = 0.8; # Slightly enhanced vibrancy for better contrast
      contrast = 1;
      popups = false; # Keep blur for popups
      brightness = 0.7;
      vibrancy_darkness = 0.1;
    };
  };
}
