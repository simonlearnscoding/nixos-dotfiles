{
  pkgs,
  lib,
  inputs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    wine64
    spotify
    blocky

    # development tools
    (pkgs-unstable.neovide)
    code-cursor
    gitkraken
    filezilla
    postman

    bitwig-studio

    # logmein-hamachi
    anki

    # setup stuff
    wofi
    hyprpanel
    # gnome-bluetooth # needed for ax-shell
    swappy # this one is for editing snapshots

    (pkgs-unstable.mongodb-compass)
    # dependencies for ags
    # material-design-icons
    # gnome-shell
    # gjs # for gnome-shell (depen)
    # nwg-dock
  ];

  # services.flatpak.enable = true;
  imports = [
    ./../ags.nix
    ./../wlsunset.nix
    ./../hyprpanel.nix
    ./../obs-studio.nix
    # ./../spotify.nix
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

  # ax shell setup
}
