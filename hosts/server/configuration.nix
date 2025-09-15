{
  config,
  pkgs,
  inputs,
  ...
}: let
  UUID = "04c67b4a-ead1-4613-9abc-2985e9202e5c";
in {
  imports = [
    #     inputs.xremap-flake.nixosModules.default
    ./hardware-configuration.nix
    ./../common.nix
    ./../../modules/ci-user.nix
    ./../serverstuff.nix
  ];

  environment.systemPackages = with pkgs; [
    xorg.xauth
    firefox # in case I ever need to login via browser
    cloudflared
  ];
  # networking.interfaces.enp1s0.ipv4.addresses = [
  #   {
  #     address = "192.168.1.23";
  #     prefixLength = 24;
  #   }
  # ];

  hardware.enableRedistributableFirmware = true;
  boot.extraModulePackages = with pkgs.linuxPackages; [
    rtl88xxau-aircrack # common Realtek driver
  ];

  ##########################
  ## User & Hardware Setup
  ##########################

  # Enable Intel iGPU video acceleration
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [intel-media-driver];
  };

  # Put user `simon` in video group so Jellyfin can use GPU
  users.users.simon.extraGroups = ["video"];
  programs.zsh.enable = true;
  networking.hostName = "simon-server";
  programs.gamemode.enable = true;

  services.fstrim.enable = true; # runs weekly via timer
  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/${UUID}";
    fsType = "ext4";
    options = ["nofail" "x-systemd.device-timeout=1s" "x-systemd.automount"];
  };
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
