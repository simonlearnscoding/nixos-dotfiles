{pkgs, ...}: let
  mainMod = "Super";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Keybindings
      # Window rules
      extraConfig = ''
        windowrulev2 = opacity 0.90 0.90,class:^(firefox)$
        windowrulev2 = opacity 0.90 0.90,class:^(Brave-browser)$
        windowrulev2 = opacity 0.80 0.80,class:^(Steam)$
        windowrulev2 = opacity 0.80 0.80,class:^(steam)$
        windowrulev2 = opacity 0.80 0.80,class:^(spotify)$
        windowrulev2 = opacity 0.80 0.80,class:^(Code)$
        windowrulev2 = opacity 0.80 0.80,class:^(org.kde.dolphin)$
        windowrulev2 = float,class:^(qt5ct)$
        windowrulev2 = float,class:^(nwg-look)$
        windowrulev2 = float,class:^(Signal)$
        windowrulev2 = float,class:^(spotify)$
        windowrulev2 = float,class:^(slack)$
        windowrulev2 = opacity 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
      '';
    };
  };
}
