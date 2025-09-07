{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/vm-module.nix
    ../common.nix
    ../gui.nix
  ];

  networking.hostName = "simon-laptop";

  programs.gamemode.enable = true;
  programs.steam.enable = true;
}
