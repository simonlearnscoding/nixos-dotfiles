# hyprland.nix
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

  xdg.configFile."hypr" = {
    source = ./hypr;
    recursive = true;
  };


  xdg.configFile."dunst" = {
    source = ./dunst;
    recursive = true;
  };
}
