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

  programs.zsh.enable = true;
  networking.hostName = "simon-server";
  programs.gamemode.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
