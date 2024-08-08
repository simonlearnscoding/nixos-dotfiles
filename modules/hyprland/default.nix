{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprland
    libnotify
    swww
    dunst
    rofi-wayland
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    waybar
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";  # Keeps the old behavior
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

# services.dunst = {
#   enable = true;
#   settings = {
#     global = {
#       width = 300;
#       height = 300;
#       offset = "30x50";
#       origin = "top-center";
#     };
#   };
# };
# TODO: move this to home man
# xdg.configFile."hypr" = {
#   source = ./hypr;
#   recursive = true;
# };

  # Enable dunst to start automatically
  systemd.user.services.dunst = {
    description = "Dunst Notification Daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
    };
  };
}
