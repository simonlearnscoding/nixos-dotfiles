{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  # Configurable parameters
  siteName = "simone-muscas-site";
  domain = "simone-muscas.com";
  port = 3000;
  user = "simon";
  # Derivation building the app for Next.js
  # websiteApp = pkgs.buildNpmPackage rec {
  #   name = "server-dashboard";
  #   src = inputs.server-dashboard;
  #   dontSandbox = true;
  #   # Ensure the build script runs next build
  #
  #   npmDepsHash = "sha256-EC8o+25so3UYHAdxyprPgxllzB5jwYpDxUDwRMfn7xc=";
  #   buildPhase = ''
  #     npm run build
  #   '';
  #
  #   installPhase = ''
  #     mkdir -p $out
  #     cp -r package.json package-lock.json node_modules .next public $out/
  #   '';
  #
  #   meta.mainProgram = "npm";
  # };
in {
  # Systemd service using the built Next.js package
  # systemd.services.${siteName} = {
  #   description = "Production service for ${domain}";
  #   wantedBy = ["multi-user.target"];
  #
  #   serviceConfig = {
  #     Type = "simple";
  #     User = user;
  #     Group = user;
  #     WorkingDirectory = "${websiteApp}";
  #     # Using npm start, which should be defined as "next start -p 3000" in package.json
  #     ExecStart = "${pkgs.nodejs}/bin/npm start";
  #     Restart = "on-failure";
  #     Environment = [
  #       "NODE_ENV=production"
  #       "PORT=${toString port}"
  #     ];
  #     # EnvironmentFile = config.age.secrets."${siteName}-env".path;
  #   };
  # };

  # Cloudflare tunnel configuration remains unchanged
  services.cloudflared.enable = true;
  services.cloudflared.tunnels.${siteName} = {
    credentialsFile = "/etc/cloudflared/simone-tunnel.json";
    ingress."${domain}" = "http://localhost:3000";
    default = "http_status:404";
  };

  # CI/CD user setup
  # users.users.ci-deployer = {
  #   isNormalUser = true;
  #   extraGroups = ["wheel"];
  #   openssh.authorizedKeys.keys = [
  #     "ssh-ed25519 ..." # Add CI/CD public key
  #   ];
  # };

  # # Security: Least privilege for CI/CD
  # security.sudo.extraRules = [
  #   {
  #     users = ["ci-deployer"];
  #     commands = [
  #       {
  #         command = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild";
  #         options = ["NOPASSWD"];
  #       }
  #       {
  #         command = "/run/current-system/ws/bin/systemctl restart ${siteName}";
  #         options = ["NOPASSWD"];
  #       }
  #     ];
  #   }
  # ];
}
# sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
# sha256-yvws17MOL7fngs73hbwo0Tzaes3/G1HoqQV3LXARq7A=
# Add this line with the correct hash from the error:

