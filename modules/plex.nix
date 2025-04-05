{...}: {
  services.plex = {
    enable = true;
    dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
    user = "plex"; # User to run the Plex Media Server as.
    group = "plex"; # Group to run the Plex Media Server as.
  };
  services.caddy = {
    enable = true;
    virtualHosts."plex.simone-muscas.com" = {
      extraConfig = ''
        reverse_proxy localhost:32400
      '';
    };
  };
}
