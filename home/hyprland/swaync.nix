# home.nix
{
  # stylix.targets.swaync.enable = true; # Stylix themes swaync
  services.swaync = {
    enable = true;
    settings = {
      position = "top-right";
      control-center-position = "right";
      timeout = 7000;
      widgets = ["inhibitors" "notification-list" "buttons-grid"];
    };
    # Optional: tiny CSS tweaks without touching colors
    style = ''
      .notification, .widget { border-radius: 12px; }
    '';
  };
}
