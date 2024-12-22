# hosts/common.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../modules/sops.nix
    ./../modules/syncthing.nix
    ./../modules/gc.nix
    ./../modules/swap.nix
    ./../modules/fonts.nix
    ./../modules/environment-variables.nix
    # ./../modules/gnome.nix
    ./../modules/hardware.nix
    ./../modules/bootloader.nix
    ./../modules/networking.nix
    ./../modules/gnupg.nix
    ./../modules/user.nix
    ./../modules/system.nix
    ./../modules/locale.nix
    ./../modules/devshells.nix
  ];

  environment.sessionVariables = {
    FLAKE = "/home/simon/nixos-dotfiles";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
