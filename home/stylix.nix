{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable Stylix and set specific options
  programs.stylix = {
    enable = true;
    theme = "rose-pine"; # Set the theme to Rose Pine
    font = "JetBrains Mono"; # Set the font to JetBrains Mono
    image = ../files/wallpapers/wallpaper.jpg; # Set wallpaper directory
  };

  # Additional Stylix configurations
  stylix = {
    windowRadius = 8; # Example: Adjust window border radius
    padding = 8; # Example: Adjust padding around elements
  };
}
