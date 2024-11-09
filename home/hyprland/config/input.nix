# hyprland/input.nix
{
  kb_layout = "us,de";
  kb_options = "grp:alt_caps_toggle";
  numlock_by_default = true;
  follow_mouse = 1;
  sensitivity = 1.4;
  touchpad = {
    natural_scroll = true;
  };

  mouse = {
    accel_profile = "adaptive"; # Options: "flat" or "adaptive"
    accel_speed = 0.5; # Range -1 (slow) to 1 (fast)
  };
}
