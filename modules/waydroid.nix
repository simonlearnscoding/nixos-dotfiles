{
  config,
  pkgs,
  ...
}: {
  # Enable Waydroid (system-wide)
  virtualisation.waydroid.enable = true;

  # Optional: Add Android udev rules (for ADB debugging)
  services.udev.packages = with pkgs; [android-udev-rules];

  # Optional: Use isolated network mode (default is "bridge")
  virtualisation.waydroid.network = "isolated"; # or "bridge" (default)
}
