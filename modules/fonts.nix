{ pkgs, ... }:

{
  # Fonts
  fonts = {
    packages = with pkgs; [
      # Include JetBrainsMono Nerd Font
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # Include General Sans from a local directory
      (pkgs.stdenv.mkDerivation {
        pname = "general-sans";
        version = "1.0.0";
        
        # Path to the extracted General Sans font folder
        src = ./../files/fonts/general-sans;

        installPhase = ''
          mkdir -p $out/share/fonts
          cp -r $src/* $out/share/fonts/
        '';
      })
    ];

    # Font configuration
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" "Vazirmatn" ];
        sansSerif = [ "Ubuntu" "General Sans" "Vazirmatn" ];  # General Sans as default sans-serif
        monospace = [ "JetBrainsMono" ];
      };
    };
  };
}
