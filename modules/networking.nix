
{ config, pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
}
