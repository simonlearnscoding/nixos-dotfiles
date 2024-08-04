{ pkgs, ... }:
{
  home.packages = with pkgs; [
    glib
    blueman
    xdg-utils
    libsecret
    brightnessctl
    gnome.gnome-keyring
    gnome.nautilus
  ];
}
