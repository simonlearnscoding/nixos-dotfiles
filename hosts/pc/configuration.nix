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
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /home/simon/shared *(rw,sync,no_subtree_check,no_root_squash)
  '';
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  # services.logmein-hamachi.enable = true;
  # whats dbus?
  services.dbus.enable = true;
  programs.nix-ld.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
