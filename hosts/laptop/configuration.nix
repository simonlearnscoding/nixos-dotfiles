{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #     inputs.xremap-flake.nixosModules.default
    ./hardware-configuration.nix
    ./../../modules/printing.nix
    ./../../modules/audio.nix
    ./../../modules/bluetooth.nix
    ./../../modules/gc.nix
    ./../../modules/swap.nix
    ./../../modules/fonts.nix
    ./../../modules/environment-variables.nix
    ./../../modules/wayland.nix
    #./modules/hyprland/default.nix
    ./../../modules/gnome.nix
    ./../../modules/display-manager.nix
    ./../../modules/energy-management.nix
    ./../../modules/info-fetchers.nix
    ./../../modules/hardware.nix
    ./../../modules/bootloader.nix
    ./../../modules/networking.nix
    ./../../modules/programs.nix
    ./../../modules/user.nix
    ./../../modules/system.nix
    ./../../modules/locale.nix
    # ./../../modules/xserver.nix
    ./../../modules/devshells.nix
  ];

  programs.gamemode.enable = true;
  programs.steam.enable = true;
  environment.sessionVariables = {
    FLAKE = "/home/simon/.nixos";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
