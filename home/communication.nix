{ pkgs, ... }:
{
  home.packages = with pkgs; [
      telegram-desktop
      slack
      webcord
  ];
}
