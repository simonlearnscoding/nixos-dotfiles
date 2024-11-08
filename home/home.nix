{
  pkgs,
  lib,
  inputs,
  ...
}: let
  username = "simon";
  homeDirectory = "/home/${username}";
in {
  imports = [
    ./user.nix
    ./wlsunset.nix
    ./rofi.nix
    ./music-production.nix
    ./info-fetchers.nix
    ./development/default.nix
    ./browser.nix
    ./hyprland/default.nix
    #./atuin.nix // this is for sh history or something
    # TODO: only load this if gnome is on
    ./gnome.nix
    #./neovim.nix
    ./sh.nix
    ./syncthing.nix
    ./communication.nix
    ./ulauncher.nix
    ./media-tools.nix
    ./system-utilities.nix
  ];
  nixpkgs.config = {allowUnfree = true;};

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";
  };

  # Optionally, you can add your Neovim configuration here
  #   xdg.configFile."nvim" = {
  #     source = ./configfiles/nvim;
  #   };
  #   xdg.configFile."hypr" = {
  #source = ./configfiles/hypr;
  #     };
}
