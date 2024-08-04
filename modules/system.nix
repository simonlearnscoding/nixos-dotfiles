
{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.rtkit.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  services.openssh.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?
}
