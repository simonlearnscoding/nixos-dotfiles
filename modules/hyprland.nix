{pkgs, ...}: {
  # Add essential packages for system-level use
  environment.systemPackages = with pkgs; [
    hyprland # The Hyprland Wayland window manager
  ];

  # Enable Hyprland and configure Xwayland for compatibility with X11 applications
  programs.hyprland = {
    enable = true; # Enable the Hyprland window manager
    xwayland.enable = true; # Enable Xwayland to support X11 apps on Wayland
    portalPackage = pkgs.xdg-desktop-portal-hyprland; # Specify Hyprland-specific portal
  };

  # Create a session file for Hyprland in the Wayland sessions directory
  # This file tells GDM (or other display managers) how to start Hyprland
  environment.etc."wayland-sessions/hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland                  # Name of the session as it appears in the login manager
    Comment=Start Hyprland Wayland session  # Description for the session
    Exec=Hyprland                  # Command to start Hyprland
    Type=Application               # Type of the desktop entry
    DesktopNames=Hyprland          # Name associated with this desktop session
  '';
}
