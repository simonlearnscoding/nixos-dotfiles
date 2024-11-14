{
  pkgs,
  config,
  ...
}: {
  stylix.enable = true;
  stylix.image = ../files/wallpapers/wallpaper.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.targets.gnome.enable = true;
  stylix.targets.grub.enable = true;
  stylix.targets.gtk.enable = true;
  # stylix.targets.spicetify.enable = true;
}
