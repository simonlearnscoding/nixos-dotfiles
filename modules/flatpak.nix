{
  lib,
  config,
  ...
}: {
  services.flatpak = {
    enable = true;
  };

  environment.variables.XDG_DATA_DIRS = lib.mkForce [
    "/var/lib/flatpak/exports/share"
    "~/.local/share/flatpak/exports/share"
  ];
}
