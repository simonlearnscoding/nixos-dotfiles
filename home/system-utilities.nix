{pkgs, ...}: {
  home.packages = with pkgs; [
    glib
    blueman
    unzip
    xdg-utils
    networkmanagerapplet

    libsecret
    # do I still need this?
    gnome-keyring
    nautilus
  ];
}
