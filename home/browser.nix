{pkgs, ...}: {
  # Install packages
  home.packages = with pkgs; [
    firefox
    chromedriver
    google-chrome
  ];
}
