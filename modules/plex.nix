{...}: {
  services.plex = {
    enable = true;
    dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
    user = "plex"; # User to run the Plex Media Server as.
    group = "plex"; # Group to run the Plex Media Server as.
  };
}
