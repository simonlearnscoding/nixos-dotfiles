{...}: {
  services.plex = {
    enable = true;
    dataDir = "/mnt/drive/movies"; # Default directory for Plex data (can be customized).
    user = "plex"; # User to run the Plex Media Server as.
    group = "plex"; # Group to run the Plex Media Server as.
  };
}
