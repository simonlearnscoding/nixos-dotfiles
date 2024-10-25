{ config, pkgs, ... }:

{
  # Existing configurations...

  home.packages = with pkgs; [
    bitwig-studio
  ];

}
