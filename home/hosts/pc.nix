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
    blocky
    ffmpeg
    bitwig-studio
    zoom
    redis
    postman
    teamviewer
    teams-for-linux
    jetbrains.webstorm
    devenv
    direnv
    anki
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

  # Optionally, you can add your Neovim configuration here
  #   xdg.configFile."nvim" = {
  #     source = ./configfiles/nvim;
  #   };
  #   xdg.configFile."hypr" = {
  #source = ./configfiles/hypr;
  #     };
}
