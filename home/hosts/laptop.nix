{
  pkgs,
  lib,
  inputs,
  services,
  ...
}: let
  username = "simon";
  homeDirectory = "/home/${username}";
in {
  home.packages = with pkgs; [
    libnotify
    ffmpeg
    teams-for-linux

    # trying to install bfme
    wine64
    # appearently I need these
    cdrtools
    libmpg123
    gnutls
  ];

  # services.flatpak.enable = true;
  imports = [
    ./../ags.nix
    ./../user.nix
    ./../discord.nix
    ./../hyprpanel.nix
    ./../obs-studio.nix
    ./../spotify.nix
    ./../icons-theme.nix
    #./../monitor_servers.nix
    ./../lowBattery.nix
    ./../wlsunset.nix
    # ./../flatpak.nix
    ./../wofi.nix
    # ./../deluge.nix
    # ./../sops.nix
    ./../taskwarrior.nix
    ./../nwg-dock.nix
    # ./../music-production.nix
    ./../info-fetchers.nix
    ./../development/default.nix
    ./../browser.nix
    ./../hyprland/default.nix
    #./../atuin.nix // this is for sh history or something
    # ./../gnome.nix
    #./../neovim.nix
    ./../sh.nix
    ./../communication.nix
    # not using ulauncher anymore
    # ./../ulauncher.nix
    ./../media-tools.nix
    ./../system-utilities.nix
  ];
  nixpkgs.config = {allowUnfree = true;};

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}