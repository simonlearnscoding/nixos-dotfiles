{pkgs, ...}: let
  UUID = "04c67b4a-ead1-4613-9abc-2985e9202e5c";
in {
  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/${UUID}";
    fsType = "ext4";
  };
  imports = [
    ./common.nix
  ];

  # Set whether this is a desktop or server
  isDesktop = false; 
  }
