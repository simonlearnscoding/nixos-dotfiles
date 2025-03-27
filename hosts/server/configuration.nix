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
    firefox
    cloudflared
  ];
  # networking.interfaces.enp1s0.ipv4.addresses = [
  #   {
  #     address = "192.168.1.23";
  #     prefixLength = 24;
  #   }
  # ];

  programs.zsh.enable = true;
  networking.hostName = "simon-server";
  programs.gamemode.enable = true;

  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/${UUID}";
    fsType = "ext4";
  };
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
