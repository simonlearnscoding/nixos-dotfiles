{pkgs, ...}: let
  username = "simon";
  homeDirectory = "/home/${username}";
  UUID = "04c67b4a-ead1-4613-9abc-2985e9202e5c";
in {
  home.packages = with pkgs; [
    ffmpeg
    syncthing
    unzip
    devenv
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

  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/${UUID}";
    fsType = "ext4";
  };

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}
