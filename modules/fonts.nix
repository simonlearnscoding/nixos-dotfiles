{ pkgs, ... }:

{
  # Fonts
  fonts = {
    packages = with pkgs; [
      # Include JetBrainsMono Nerd Font
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" "Vazirmatn" ]; # Customize as needed
        sansSerif = [ "Ubuntu" "Vazirmatn" ];       # Customize as needed
        monospace = [ "JetBrainsMono" ];            # Set JetBrainsMono as the default monospace font
      };
    };
  };
}
