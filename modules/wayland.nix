{
  lib,
  pkgs,
  ...
}: {
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.variables.XDG_DATA_DIRS = lib.mkForce [
    "/var/lib/flatpak/exports/share"
    "~/.local/share/flatpak/exports/share"
  ];
}
