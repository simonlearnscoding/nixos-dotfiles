{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;
    virtualHosts."syncthing-proxy" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 3001;
        }
      ];

      # Only handle /syncthing paths
      locations."/syncthing/" = {
        extraConfig = ''
          # Strip /syncthing prefix when forwarding to Syncthing
          proxy_pass http://127.0.0.1:8384/;

          # Required headers
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;

          # Fix for CSS/JS paths (since Syncthing uses root-relative paths)
          sub_filter_once off;
          sub_filter_types *;  # Apply to all content types
          sub_filter '="/' '="/syncthing/';
          sub_filter 'href="/' 'href="/syncthing/';
          sub_filter 'src="/' 'src="/syncthing/';
          sub_filter 'url("/' 'url("/syncthing/';

          # WebSocket support
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        '';
      };
    };
  };
}
