{
  pkgs,
  lib,
  inputs,
  pkgs-unstable,
  ...
}: {
  # I need to permit insecure packages because of logseq for now
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
    "dotnet-runtime-7.0.20" # needed for Vintage Story
  ];
  home.packages = with pkgs; [
    wine64
    spotify
    blocky
    libreoffice
    vintagestory

    entr # for watching files and running commands
    libremines # for playing minesweeper
    logseq # notetaking like obsidian but better
    # development tools
    (pkgs-unstable.neovide)
    (pkgs-unstable.wlr-which-key)
    gitkraken
    filezilla
    postman

    # bitwig-studio -- installing it with flatpak for now

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
    ./../scripts.nix
  ];

  # ax shell setup
}
