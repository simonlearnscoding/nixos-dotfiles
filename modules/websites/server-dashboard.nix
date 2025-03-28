{
  config,
  lib,
  pkgs,
  ...
}: let
  # Configurable parameters
  siteName = "simone-muscas-site";
  domain = "simone-muscas.com";
  port = 3000;
  user = "simon";

  # Build the Docker image from the repository context (which must contain a Dockerfile)
  dockerImage = pkgs.dockerTools.buildImage {
    name = "server-dashboard";
    tag = "latest";
    # Use the entire repository as the Docker build context.
    # This assumes you have a Dockerfile at the repository root.
    contents = ./.;
    config = {
      # The image should run your Next.js app.
      # Ensure your package.json defines a "start" script like "next start -p 3000"
      Cmd = ["npm" "start"];
      Env = [
        "NODE_ENV=production"
        "PORT=${toString port}"
      ];
      ExposedPorts = {
        "3000/tcp" = {};
      };
    };
  };

  # We'll refer to the Docker image tarball built by dockerTools.
  dockerImagePath = dockerImage;
in {
  # Systemd service which loads and runs the Docker image
  systemd.services.${siteName} = {
    description = "Production service for ${domain}";
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      User = user;
      Group = user;
      # The command below loads the image from the tarball then runs a container.
      # Note: This requires the docker daemon and proper permissions.
      ExecStart = ''
        ${pkgs.docker}/bin/docker load -i ${dockerImagePath} && \
        ${pkgs.docker}/bin/docker run --rm -p ${toString port}:3000 server-dashboard:latest
      '';
      Restart = "on-failure";
    };
  };

  # Cloudflare tunnel configuration remains unchanged
  services.cloudflared.tunnels.${siteName} = {
    credentialsFile = config.age.secrets.cloudflare-tunnel-creds.path;
    ingress."${domain}" = {service = "http://localhost:${toString port}";};
    default = "http_status:404";
  };

  # CI/CD user setup
  users.users.ci-deployer = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 ..." # Add CI/CD public key
    ];
  };

  # Security: Least privilege for CI/CD
  security.sudo.extraRules = [
    {
      users = ["ci-deployer"];
      commands = [
        {
          command = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/ws/bin/systemctl restart ${siteName}";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
