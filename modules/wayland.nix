{
  lib,
  pkgs,
  ...
}: {
  # Enable xdg-desktop-portal with Hyprland + GTK backends
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland # Add this first
      xdg-desktop-portal-gtk
      # xdg-desktop-portal-gnome  # You can remove this if not needed
    ];
    config = {
      common.default = ["hyprland" "gtk"];
      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        "org.freedesktop.impl.portal.OpenURI" = ["gtk"];
      };
    };
  };

  # Force XDG_DATA_DIRS so systemd user services (like portals) see them
  # environment.variables.XDG_DATA_DIRS = lib.mkForce (
  #   "${pkgs.xdg-desktop-portal}/share:"
  #   + "${pkgs.xdg-desktop-portal-gtk}/share:"
  #   + "${pkgs.xdg-desktop-portal-hyprland}/share:"
  #   + "/usr/share"
  # );
}
