{pkgs, ...}: {
  home.packages = with pkgs; [
    flatpak
  ];
}
