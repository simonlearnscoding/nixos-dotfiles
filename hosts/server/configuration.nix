{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #     inputs.xremap-flake.nixosModules.default
    ./hardware-configuration.nix
    ./../common.nix
  ];

  networking.interfaces.wlp3s0.ipv4.addresses = [
    {
      address = "192.168.1.23";
      prefixLength = 24;
    }
  ];

  programs.zsh.enable = true;
  networking.hostName = "simon-server";
  programs.gamemode.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
