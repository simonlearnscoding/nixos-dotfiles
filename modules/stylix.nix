{
  pkgs,
  config,
  ...
}: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ../files/wallpapers/wallpaper-2.JPG;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.targets.grub.enable = true;
  stylix.targets.gtk.enable = true;
  # stylix.targets.spicetify.enable = true;
}
