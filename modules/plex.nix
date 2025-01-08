{...}: {
  services.plex = {
    enable = true;
    dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
    user = "simon"; # User to run the Plex Media Server as.
    group = "simon"; # Group to run the Plex Media Server as.
  };
}
