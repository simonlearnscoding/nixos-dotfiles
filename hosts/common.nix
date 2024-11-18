# hosts/common.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../modules/xserver.nix
    ./../modules/stylix.nix
    ./../modules/printing.nix
    ./../modules/audio.nix
    # ./../modules/sops.nix
    ./../modules/bluetooth.nix
    ./../modules/gc.nix
    ./../modules/gdm.nix
    ./../modules/wayland.nix
    ./../modules/hyprland.nix
    ./../modules/swap.nix
    ./../modules/fonts.nix
    ./../modules/environment-variables.nix
    ./../modules/gnome.nix
    ./../modules/energy-management.nix
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

  environment.systemPackages = [
    pkgs.power-profiles-daemon
  ];
  programs.zsh.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;

  environment.sessionVariables = {
    FLAKE = "/home/simon/nixos-dotfiles";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
