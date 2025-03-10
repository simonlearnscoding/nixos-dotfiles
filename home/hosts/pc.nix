{
  pkgs,
  lib,
  inputs,
  services,
  ...
}: let
  username = "simon";
  homeDirectory = "/home/${username}";
in {
  home.packages = with pkgs; [
    jetbrains.webstorm
  ];

  imports = [
    ./common.nix
    ./desktop.nix
  ];

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}
