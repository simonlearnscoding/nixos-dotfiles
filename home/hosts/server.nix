{pkgs, ...}: let
  username = "simon";
  homeDirectory = "/home/${username}";
in {
  home.packages = with pkgs; [
    ffmpeg
    syncthing
    unzip
    libsecret
  ];

  # services.flatpak.enable = true;
  imports = [
    ./../user.nix
    # ./../deluge.nix
    # ./../sops.nix
    ./../taskwarrior.nix
    ./../info-fetchers.nix
    ./../development/server.nix
    ./../sh.nix
  ];
  nixpkgs.config = {allowUnfree = true;};

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}
