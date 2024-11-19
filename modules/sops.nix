{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = ./../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/simon/.config/sops/age/keys.txt";

    secrets = {
      "SYNCTHING_SALZBURG_ID" = {
        owner = "simon";
        group = "users";
        mode = "0600";
      };
      "SYNCTHING_SCHWEIZ_ID" = {
        owner = "simon";
        group = "users";
        mode = "0600";
      };
    };
  };

  # Define a service to write secrets to a shared environment file
  systemd.services."export-secrets" = {
    script = let
      # Use pkgs.lib instead of lib
      secretsScript = pkgs.lib.concatStringsSep "\n" (map (secretName: ''
        echo "${secretName}=$(cat ${config.sops.secrets."${secretName}".path})"
      '') (builtins.attrNames config.sops.secrets));
    in ''
      echo "Exporting secrets to /etc/environment..."
      # Export all secrets to /etc/environment
      {
        ${secretsScript}
      } > /etc/environment

      # Ensure simon and root can access /etc/environment
      chown root:wheel /etc/environment
      chmod 0640 /etc/environment
    '';
    serviceConfig = {
      Type = "oneshot"; # Run once at system startup
      RemainAfterExit = true; # Keep the service active to indicate success
    };
    wantedBy = ["multi-user.target"]; # Ensure it runs at boot
  };
}
