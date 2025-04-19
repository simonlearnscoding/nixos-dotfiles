{...}: {
  services.plex = {
    enable = false;
    dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
    user = "plex"; # User to run the Plex Media Server as.
    group = "plex"; # Group to run the Plex Media Server as.
  };
  services.caddy = {
    enable = true;
    virtualHosts."plex.simone-muscas.com" = {
      extraConfig = ''
        # Required for Plex Web
        reverse_proxy localhost:32400 {
          transport http {
            tls_insecure_skip_verify  # Only if you use self-signed certs
          }
          header_up Host {host}
          header_up X-Real-IP {remote}
          header_up X-Forwarded-For {remote}
          header_up X-Forwarded-Proto {scheme}
        }

        # WebSocket support (critical for Plex)
        reverse_proxy /socket localhost:32400 {
          transport http {
            tls_insecure_skip_verify
          }
        }
      '';
    };
  };

  virtualHosts."syncthing.simone-muscas.com" = {
    extraConfig = ''
      reverse_proxy localhost:8384 {
        transport http {
          tls_insecure_skip_verify
        }
        header_up Host {host}
        header_up X-Real-IP {remote}
        header_up X-Forwarded-For {remote}
        header_up X-Forwarded-Proto {scheme}
      }
    '';
  };
}
