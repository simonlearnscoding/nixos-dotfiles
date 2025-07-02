{
  pkgs,
  pkgs-unstable,
  ...
}: let
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
    package = pkgs-unstable.hyprland;
    plugins = [
      # this makes it like paperwm but I dont want it for now
      # pkgs.hyprlandPlugins.hyprscroller

      # this is for touch gestures, gotta try on laptop
      pkgs-unstable.hyprlandPlugins.hyprgrass

      # overview of workspaces
      pkgs-unstable.hyprlandPlugins.hyprspace

      pkgs-unstable.hyprlandPlugins.hypr-dynamic-cursors
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
      monitor=,preferred,auto,auto
      # exec-once = nwg-dock-hyprland -d -hd 0
      exec-once = hyprpanel
      exec-once = hypridle
      exec-once = ags
      exec-once = nwg-panel
      exec-once = /home/simon/nixos-dotfiles/home/scripts/start_waybar.sh
      exec-once = /home/simon/nixos-dotfiles/home/scripts/battery-monitor.sh
      xwayland {
        force_zero_scaling = true;
      }
    '';
  };
  systemd.user.services.ax-shell = {};
}
