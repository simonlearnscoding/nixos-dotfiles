{pkgs, ...}: {
  home.packages = with pkgs; [
    glib
    blueman
    unzip
    xdg-utils
    libsecret
    brightnessctl
    gnome.gnome-keyring
    gnome.nautilus
  ];
}
