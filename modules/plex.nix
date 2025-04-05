{...}: {
  services.plex = {
    enable = false;
    # dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
    # user = "plex"; # User to run the Plex Media Server as.
    # group = "plex"; # Group to run the Plex Media Server as.
  };
  # systemd.services.plex.environment = {
  #   PLEX_CLAIM = "claim-tykNGBz5fDp_hKv4KSok";
  # };
  services.caddy = {
    enable = true;
    virtualHosts."plex.simone-muscas.com" = {
      extraConfig = ''
            reverse_proxy localhost:32400{
            transport http {
                tls_insecure_skip_verify

              }
              header_up Host {host}
              header_up X-Real-IP {remote}
              header_up X-Forwarded-Proto {scheme}
        }
      '';
    };
  };
}
