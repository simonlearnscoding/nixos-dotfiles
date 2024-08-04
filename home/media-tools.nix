
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    syncthing
    xdg-utils
  ];
}
