{pkgs, ...}: {
  imports = [
    ./common.nix
  ];

  # Set whether this is a desktop or server
  isDesktop = true;
}
