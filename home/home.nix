
{ pkgs, lib, inputs, ... }: let
  username = "simon";
  homeDirectory = "/home/${username}";
in
{
  imports = [
    ./user.nix
    ./development/default.nix
    ./browser.nix
    ./sh.nix
    ./syncthing.nix
    ./communication.nix
    ./media-tools.nix
    ./system-utilities.nix
  ];
  nixpkgs.config = { allowUnfree = true; };

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };
}
