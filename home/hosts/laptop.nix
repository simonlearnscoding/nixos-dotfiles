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
  imports = [
    ./../battery-monitor.nix
    ./common.nix
    ./desktop.nix
  ];

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}
