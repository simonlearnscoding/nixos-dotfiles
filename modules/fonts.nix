
{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" "Vazirmatn" ];
        sansSerif = [ "Ubuntu" "Vazirmatn" ];
        monospace = [ "JetBrainsMono" ];
      };
    };
  };
}
