{pkgs, ...}: let
  term = "kitty";
  editor = "nvim";
  file = "nautilus";
  browser = "firefox";
in {
  imports = [
    ./keybinds.nix
    ./animations.nix
    ./touch-gestures.nix
    ./windowrules.nix
    ./blur.nix
    ./monitors.nix
    # {inherit term editor file browser;}
  ];

  home.packages = with pkgs; [
    rose-pine-cursor
  ];
  home.sessionVariables = {
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "rose-pine-cursor";
  };
  wayland.windowManager.hyprland = {
    plugins = [
      # this makes it like paperwm but I dont want it for now
      # pkgs.hyprlandPlugins.hyprscroller

      # this is for touch gestures, gotta try on laptop
      pkgs.hyprlandPlugins.hyprgrass

      # overview of workspaces
      pkgs.hyprlandPlugins.hyprspace

      pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ];

    enable = true;
    settings = {
      plugin = {
        dynamic-cursors = {
          enable = true;
          mode = "stretch";
        };
      };

      input = import ./input.nix;
      # applications = {
      #   inherit term editor file browser;
      # };
    };
    extraConfig = ''
      # exec-once = ${pkgs.uwsm}/bin/uwsm --app ${pkgs.python3}/bin/python3 ~/.config/Ax-Shell/main.py
       monitor=,preferred,auto,auto
       # exec-once = nwg-dock-hyprland -d -hd 0

      exec-once = ./../../scripts/battery-monitor.sh
      exec-once = hyprpanel
      exec-once = waybar -c ~/.config/waybar/config.json
      exec-once = ags
       exec-once = nwg-panel
       xwayland {
         force_zero_scaling = true;
       }
    '';
  };
  systemd.user.services.ax-shell = {};
}
