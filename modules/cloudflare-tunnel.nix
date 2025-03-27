{
  config,
  lib,
  pkgs,
  ...
}: let
  tunnelId = "b02ec08a-126a-4fe1-acae-0dd7b690447e";
  credentialsPath = "/etc/cloudflared/simone-tunnel.json";
  domain = "simone-muscas.com";
in {
  options = {};

  config = {
    services.cloudflared = {
      enable = true;
      tunnels = {
        "${tunnelId}" = {
          credentialsFile = credentialsPath;
          ingress = {
            "${domain}" = {
              service = "http://localhost:3000";
            };
          };
          default = "http_status:404";
        };
      };
    };
  };
}
