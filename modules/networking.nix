
{ config, pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  # Enable GNOME control center for network settings
  # Additional packages and MIME type configuration
  environment.systemPackages = with pkgs; [
    gnome-control-center
    gnome-keyring
  ];

# services.gnome.gnome-control-center.enable = true;
  # Enable GNOME keyring
  services.gnome.gnome-keyring.enable = true;

}
