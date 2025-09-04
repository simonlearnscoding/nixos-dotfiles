{pkgs, ...}: {
  home.packages = with pkgs; [
    glib
    blueman
    unzip
    xdg-utils

    # do I still need this?
    libsecret
    gnome-keyring

    nautilus
  ];
}
