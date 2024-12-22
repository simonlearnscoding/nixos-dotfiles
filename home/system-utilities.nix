{pkgs, ...}: {
  home.packages = with pkgs; [
    glib
    blueman
    unzip
    xdg-utils
    libsecret
    brightnessctl
    gnome-keyring
    nautilus
  ];
}
