{pkgs, ...}: let
  username = "simon";
  homeDirectory = "/home/${username}";
  UUID = "04c67b4a-ead1-4613-9abc-2985e9202e5c";
in {
  # services.flatpak.enable = true;
  imports = [
    ./common.nix
  ];

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
