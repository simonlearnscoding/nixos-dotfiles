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
    ./../gui.nix
  ];

  networking.hostName = "simon-pc";
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  # services.logmein-hamachi.enable = true;
  # whats dbus?
  services.dbus.enable = true;
  programs.nix-ld.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
