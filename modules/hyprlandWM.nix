{pkgs, ...}: {
  # removing this crashes ags for some reason?
  environment.systemPackages = with pkgs; [
    hyprland
  ];

  # services.xserver.displayManager.sddm.enable = true;
  programs.hyprland.enable = true; # Enable the Hyprland window manager

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
