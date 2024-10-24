
{ config, pkgs, ... }:

{
# TODO: why light?
  programs.light.enable = true;
 programs.fish.enable = false;
 programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    iw
    wpa_supplicant
    networkmanager
    # wl-clipboard
    wget
    pulseaudio
    gnumake
    gcc
    alsa-utils
    xclip
    pavucontrol
    home-manager
  ];

# what is this doing?
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
