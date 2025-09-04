{pkgs, ...}: {
  stylix.enable = true;
  stylix.autoEnable = true;

  stylix.image = ../files/wallpapers/wallpaper-2.JPG;

  # Pick a Catppuccin variant from base16-schemes
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

  stylix.targets.plymouth.enable = false; # avoid conflicts
  stylix.targets.grub.enable = true;
  stylix.targets.gtk.enable = true;
}
