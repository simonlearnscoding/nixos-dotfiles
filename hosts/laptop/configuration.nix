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

  networking.hostName = "simon-laptop";
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  environment.sessionVariables = {
    FLAKE = "/home/simon/.nixos";
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
