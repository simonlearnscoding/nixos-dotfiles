{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    ffmpeg
    direnv
    devenv
    mongodb
    mongodb-tools
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
    # ./../sops.nix
    ./../info-fetchers.nix
    ./../atuin.nix
    ./../taskwarrior.nix
    ./../system-utilities.nix
    ./../development/default.nix

    ./../sh.nix
  ];

  nixpkgs.config = {allowUnfree = true;};
}
