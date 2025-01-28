{pkgs, ...}: {
  home.packages = with pkgs; [
    # this gives a signal when battery is low
    batsignal
  ];
  imports = [
    ./common.nix
  ];

  # Set whether this is a desktop or server
  isDesktop = true;
}
