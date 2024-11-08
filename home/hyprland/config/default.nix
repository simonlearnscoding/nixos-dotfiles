{...}: let
  term = "kitty";
  editor = "nvim";
  file = "nautilus";
  browser = "firefox";
in {
  imports = [
    ./keybinds.nix
    ./animations.nix
    ./windowrules.nix
    ./monitors.nix
    # {inherit term editor file browser;}
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input = import ./input.nix;
      # applications = {
      #   inherit term editor file browser;
      # };
    };
    extraConfig = ''
       monitor=,preferred,auto,auto

      exec-once = hyprpanel
       xwayland {
         force_zero_scaling = true;
       }
    '';
  };
}
