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
  security.sudo.enable = true;
  boot.extraModulePackages = with pkgs.linuxPackages; [
    rtl88xxau-aircrack
  ];

  # Enable Intel iGPU video acceleration
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [intel-media-driver];
  };

  users.users.simon.extraGroups = ["video" "wheel"];
  programs.zsh.enable = true;
  networking.hostName = "simon-server";
  programs.gamemode.enable = true;

  ##########################
  ## Drive Configuration
  ##########################

  services.fstrim.enable = true;

  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/${UUID}";
    fsType = "ext4";
    options = ["nofail" "x-systemd.device-timeout=1s"];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/drive 0755 simon users -"
  ];

  # USB drive watcher service
  systemd.services.drive-watcher = {
    description = "Watch for and mount 8TB USB drive";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = let
        script = pkgs.writeScript "mount-drive" ''
          #!/bin/sh
          if [ -b "/dev/disk/by-uuid/${UUID}" ] && ! mountpoint -q /mnt/drive; then
            echo "Drive found, mounting..."
            systemctl start mnt-drive.mount
          else
            echo "Drive not found or already mounted"
          fi
        '';
      in "${script}";
    };
  };

  services.udev.extraRules = ''
    # Only act on USB devices with your specific UUID
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_BUS}=="usb", ENV{ID_FS_UUID}=="${UUID}", RUN+="${pkgs.systemd}/bin/systemctl start drive-watcher.service"
    ACTION=="remove", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="${UUID}", RUN+="${pkgs.systemd}/bin/systemctl stop mnt-drive.mount"
  '';

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
