{
  config,
  pkgs,
  ...
}: {
  # Install necessary applications
  home.packages = with pkgs; [
    syncthing
    mpv
    qutebrowser # Minimal, keyboard-focused web browser
    zathura # PDF viewer
    imv # Lightweight image viewer
    bluetuith
    xdg-utils # Ensures basic XDG functionality
    viewnior # Image viewer
    audacious # Audio player
  ];
  services.blueman-applet.enable = true;
  fonts.fontconfig.enable = true;

  # Enable XDG MIME application settings
  xdg.mimeApps.enable = true;

  # Define default applications for file types
  xdg.mimeApps.defaultApplications = {
    "video/*" = ["mpv.desktop"]; # Default video player
    "audio/*" = ["audacious.desktop"]; # Default audio player
    "image/*" = ["viewnior.desktop"]; # Default image viewer
    "application/pdf" = ["zathura.desktop"]; # Default PDF viewer
    "text/html" = ["firefox.desktop"]; # Default browser for HTML links
    "x-scheme-handler/http" = ["firefox.desktop"]; # For HTTP links
    "x-scheme-handler/https" = ["firefox.desktop"]; # For HTTPS links
  };

  # Enable MPV configuration
  programs.mpv.enable = true;
}
