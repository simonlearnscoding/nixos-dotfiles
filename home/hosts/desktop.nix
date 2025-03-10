{
  pkgs,
  lib,
  inputs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    teams-for-linux
    gitkraken
    neovide
    webcord
    wine64
    spotify
    hyprpanel
    wofi
    zoom
    blocky
    filezilla
    bitwig-studio
    postman
    anki
    teamviewer
    (pkgs-unstable.mongodb-compass)
    nwg-dock
  ];

  # services.flatpak.enable = true;
  imports = [
    ./../ags.nix
    ./../wlsunset.nix
    ./../discord.nix
    ./../hyprpanel.nix
    ./../obs-studio.nix
    ./../spotify.nix
    ./../icons-theme.nix
    ./../wofi.nix
    ./../nwg-dock.nix
    ./../browser.nix
    #./../monitor_servers.nix
    # ./../music-production.nix
    # ./../gnome.nix
    ./../hyprland/default.nix
    ./../communication.nix
    ./../media-tools.nix
    ./../lowBattery.nix
  ];
}
