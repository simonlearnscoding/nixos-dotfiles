{
  config,
  pkgs,
  inputs,
  ...
}: let
  UUID = "04c67b4a-ead1-4613-9abc-2985e9202e5c";
in {
  imports = [
    ./hardware-configuration.nix
    ./../common.nix
    ./../serverstuff.nix
  ];

  environment.systemPackages = with pkgs; [
    xorg.xauth
    firefox
    cloudflared
  ];

  hardware.enableRedistributableFirmware = true;
  boot.extraModulePackages = with pkgs.linuxPackages; [
    rtl88xxau-aircrack
  ];

  programs.zsh.enable = true;
  networking.hostName = "simon-server";

  services.fstrim.enable = true;

  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/${UUID}";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=1s"
      "x-systemd.automount"
    ];
  };

  # Mount the moment the disk appears
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="${UUID}", ENV{SYSTEMD_WANTS}+="mnt-drive.mount"
  '';

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
