{ config, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.xremap-flake.nixosModules.default
      ./hardware-configuration.nix
      ./modules/xremap.nix
      ./modules/audio.nix
      ./modules/fonts.nix
      ./modules/hyprland/default.nix
      ./modules/energy-management.nix
      ./modules/hardware.nix
      ./modules/bootloader.nix
      ./modules/networking.nix
      ./modules/programs.nix
      ./modules/user.nix
      ./modules/system.nix
      ./modules/locale.nix
      ./modules/xserver.nix
    ];

  environment.sessionVariables = {
    FLAKE = "/home/simon/.nixos";
  };
}
