{
  pkgs,
  lib,
  pkgs-unstable,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    ncdu # shows disk usage per folder
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
  programs = {

    awscli = {
      enable = true;
      package = pkgs.awscli2; # v2 is recommended
    };
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };

  imports = [
    ./../info-fetchers.nix
    ./../atuin.nix
    ./../taskwarrior.nix
    ./../nvf/nvf.nix
    ./../system-utilities.nix
    ./../development/default.nix

    ./../sh.nix
  ];

  nixpkgs.config = {allowUnfree = true;};
}
