{ config, lib, pkgs, ... }:
let
  # Configurable parameters
  siteName = "simone-muscas-site";
  domain = "simone-muscas.com";
  port = 3000;
  repoUrl = "git@github.com:simonlearnscoding/server-dashboard.git";
  user = "simon";
  
  # Derivation building the app
  websiteApp = pkgs.buildNpmPackage rec {
    name = "server-dashboard";
    src = pkgs.fetchFromGitHub {
      owner = "simonlearnscoding";
      repo = "server-dashboard";
      rev = "main"; # Consider pinning to specific rev in production
    };
    
    
    buildPhase = ''
      npm run build
    '';
    
    installPhase = ''
      mkdir -p $out
      cp -r package.json package-lock.json node_modules dist $out/
    '';
    
    meta.mainProgram = "npm";
  };
in {
  # Systemd service using built package
  systemd.services.${siteName} = {
    description = "Production service for ${domain}";
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "simple";
      User = user;
      Group = user;
      WorkingDirectory = "${websiteApp}";
      ExecStart = "${pkgs.nodejs}/bin/npm start";
      Restart = "on-failure";
      Environment = "NODE_ENV=production PORT=${toString port}";
      EnvironmentFile = config.age.secrets."${siteName}-env".path;
    };
  };

  # Cloudflare tunnel configuration
  services.cloudflared.tunnels.${siteName} = {
    credentialsFile = config.age.secrets.cloudflare-tunnel-creds.path;
    ingress."${domain}" = { service = "http://localhost:${toString port}"; };
    default = "http_status:404";
  };

  # CI/CD user setup
  users.users.ci-deployer = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 ..." # Add CI/CD public key
    ];
  };

  # Security: Least privilege for CI/CD
  security.sudo.extraRules = [{
    users = [ "ci-deployer" ];
    commands = [ 
      { command = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
      { command = "systemctl restart ${siteName}"; options = [ "NOPASSWD" ]; }
    ];
  }];
}
