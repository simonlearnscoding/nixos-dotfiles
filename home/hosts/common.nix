{
  pkgs,
  lib,
  pkgs-unstable,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    sqlite
    ffmpeg
    dysk
    direnv
    (pkgs-unstable.devenv)
    # pkgs-unstable.mongodb
    # mongodb-tools
    redis
    unzip
    syncthing
    libsecret
    cdrtools
    deluge
    libmpg123
    gnutls
  ];

  imports = [
    ./../info-fetchers.nix
    ./../atuin.nix
    ./../taskwarrior.nix
    ./../system-utilities.nix
    ./../development/default.nix

    ./../sh.nix
  ];

  nixpkgs.config = {allowUnfree = true;};
}
