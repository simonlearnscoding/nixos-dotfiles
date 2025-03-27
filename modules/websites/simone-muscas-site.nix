{
  config,
  pkgs,
  lib,
  ...
}: let
  sitePath = "/home/simon/code";
  repoUrl = "git@github.com:simonlearnscoding/server-dashboard.git";
in {
  systemd.services.simone-muscas-site = {
    description = "Simone Muscas Server Website ";
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      WorkingDirectory = sitePath;

      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '
          if [ ! -d server-dashboard ]; then
            git clone ${repoUrl}
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
}
