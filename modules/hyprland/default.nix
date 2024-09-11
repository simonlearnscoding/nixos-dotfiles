{ pkgs, ... }:

{
  # Enable X server and GDM as the display manager
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Include the Hyprland session and necessary packages
  environment.systemPackages = with pkgs; [
    hyprland
    hyprlock
    pyprland
    hypridle
    hyprpicker
    hyprcursor
    hyprpaper
    libnotify
    swww
    dunst
    rofi-wayland
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    waybar
    # starship # I am using p10k instead
    qutebrowser
    zathura
    mpv
    imv
  ];

  # Enable Hyprland and configure Xwayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG portal configuration for Wayland compatibility
  xdg.portal = {
    enable = true;
    config.common.default = "*";  # Keeps the old behavior
  };

  # Set necessary session variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Enable dunst to start automatically with the user session
  systemd.user.services.dunst = {
    description = "Dunst Notification Daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
    };
  };

  # Create a session file for Hyprland in the Wayland sessions directory
  environment.etc."wayland-sessions/hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=Start Hyprland Wayland session
    Exec=Hyprland
    Type=Application
    DesktopNames=Hyprland
  '';
}
