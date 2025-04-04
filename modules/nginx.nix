{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;

    upstreams.syncthing.servers = {
      "127.0.0.1:8384" = {};
    };

    virtualHosts."syncthing-proxy" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 3001;
        }
      ];

      locations."/syncthing/" = {
        extraConfig = ''
          rewrite ^/syncthing(/.*)$ $1 break;
        '';
        proxyPass = "http://syncthing";
        proxyWebsockets = true;
      };
    };
  };
}
