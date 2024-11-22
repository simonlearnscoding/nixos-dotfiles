{...}: {
  services.flatpak = {
    enable = true;
    extraPkgs = pkgs:
      with pkgs; [
        flatpak
        gnome3.gnome-software
        gnome3.gnome-software-plugin-flatpak
      ];
  };
}
