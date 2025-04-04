{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 3001;
        }
      ];
      locations."/syncthing/" = {
        # Only allow requests with auth header from Next.js
        extraConfig = ''
          proxy_pass http://127.0.0.1:8384/;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;

          # Auth check (replace with your token)
          if ($http_auth_token != "SECRET_TOKEN") {
            return 403;
          }
        '';
      };
    };
  };
}
