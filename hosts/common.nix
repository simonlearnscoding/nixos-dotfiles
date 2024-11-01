# hosts/common.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../modules/printing.nix
    ./../modules/audio.nix
    ./../modules/bluetooth.nix
    ./../modules/gc.nix
    ./../modules/swap.nix
    ./../modules/fonts.nix
    ./../modules/environment-variables.nix
    ./../modules/gnome.nix
    ./../modules/energy-management.nix
    ./../modules/info-fetchers.nix
    ./../modules/hardware.nix
    ./../modules/bootloader.nix
    ./../modules/networking.nix
    ./../modules/light.nix
    ./../modules/gnupg.nix
    ./../modules/user.nix
    ./../modules/system.nix
    ./../modules/locale.nix
    ./../modules/devshells.nix
  ];

  programs.gamemode.enable = true;
  programs.steam.enable = true;

  environment.sessionVariables = {
    FLAKE = "/home/simon/.nixos";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
