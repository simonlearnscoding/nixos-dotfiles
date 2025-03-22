{pkgs, ...}: let
  username = "simon";
  homeDirectory = "/home/${username}";
in {
  imports = [
    ./common.nix
  ];

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}
