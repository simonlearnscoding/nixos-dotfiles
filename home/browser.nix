{pkgs, ...}: {
  # Install packages
  home.packages = with pkgs; [
    firefox
    google-chrome
  ];
}
