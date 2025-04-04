{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;

    # Define Syncthing as an upstream service
    upstreams.syncthing.servers = {
      "127.0.0.1:8384" = {};
    };

    virtualHosts."syncthing.yourdomain.com" = {
      # Only listen on localhost since Cloudflare will proxy to this
      listen = [
        {
          addr = "127.0.0.1";
          port = 3001;
        }
      ];
      serverName = "syncthing.yourdomain.com";

      locations."/" = {
        proxyPass = "http://syncthing";
        proxyWebsockets = true; # For real-time updates

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;

          # Cleaner path rewriting using map directive
          proxy_redirect ~^(https?://[^/]+)(/.+)$ $1/syncthing$2;
        '';
      };
    };
  };
}
