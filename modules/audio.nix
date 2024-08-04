
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pamixer
    ripgrep
  ];
}
