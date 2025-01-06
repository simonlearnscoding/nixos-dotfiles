{...}: {
  services.plex = {
    enable = true;
    acceptedEula = true; # You must accept the Plex EULA.
    dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
  };
}
