{ pkgs, ... }:

{
  # Basic system settings
  imports = [ 
    # Example: Add your own NixOS modules here
  ];

  # Enable the X server
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Remove decorations for QT applications
  environment.sessionVariables = {
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  # Excluding some GNOME applications from the default install
  environment.gnome.excludePackages =
    (with pkgs; [
      gedit
      gnome-connections
      gnome-console
      gnome-photos
      gnome-tour
      snapshot
    ])
    ++ (with pkgs.gnome; [
      atomix # puzzle game
      baobab # disk usage analyzer
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gnome-characters
      gnome-logs
      gnome-maps
      gnome-shell-extensions
      gnome-system-monitor
      gnome-terminal
      gnome-weather
      hitori # sudoku game
      iagno # go game
      simple-scan
      tali # poker game
      yelp # help viewer
    ]);

  # List of Gnome specific packages
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
#   gnomeExtensions.auto-move-windows
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.pop-shell
    gnomeExtensions.space-bar
    gnomeExtensions.appindicator

    gnomeExtensions.user-themes
  ];


  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs (old: {
          src = pkgs.fetchFromGitLab  {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-46";
            # Update the hash to the correct one
            hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
          };
        });
      });
    })
  ];
}
