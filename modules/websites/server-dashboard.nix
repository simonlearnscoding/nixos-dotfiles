{ config, lib, pkgs, ... }:

let
  siteName = "simone-muscas-site";
  repoUrl = "git@github.com:simonlearnscoding/server-dashboard.git";
  tunnelId = "b02ec08a-126a-4fe1-acae-0dd7b690447e";
  credentialsPath = "/etc/cloudflared/simone-tunnel.json";
  domain = "simone-muscas.com";
  port = 3000;
  sitePath = "/home/simon/code";
in {
  systemd.services.${siteName} = {
    description = "Simone Muscas Server Website";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      WorkingDirectory = sitePath;

      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '
          if [ ! -d server-dashboard ]; then
            git clone ${repoUrl}
          else
            cd server-dashboard && git pull
          fi
          cd server-dashboard
          npm install
          npm run build
          npm start
        '
      '';

      Restart = "on-failure";
      User = "simon";
      Environment = "NODE_ENV=production";
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "${tunnelId}" = {
        credentialsFile = credentialsPath;
        ingress = {
          "${domain}" = {
            service = "http://localhost:${toString port}";
          };
        };
        default = "http_status:404";
      };
    };
  };
}
