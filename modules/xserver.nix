
{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver.videoDrivers = ["amd"];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
