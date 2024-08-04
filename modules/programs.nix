
{ config, pkgs, ... }:

{
  programs.light.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    iw
    wpa_supplicant
    networkmanager
    wl-clipboard
    wget
    pulseaudio
    gnumake
    gcc
    alsa-utils
    xclip
    pavucontrol
    home-manager
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
