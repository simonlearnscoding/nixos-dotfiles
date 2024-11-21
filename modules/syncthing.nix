{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services.syncthing = {
    serviceConfig = {
      # Set environment variables to point to the secret file paths
      Environment = {
        SYNCTHING_SCHWEIZ_ID = "${config.sops.secrets.SYNCTHING_SCHWEIZ_ID.path}";
        SYNCTHING_SALZBURG_ID = "${config.sops.secrets.SYNCTHING_SALZBURG_ID.path}";
      };

      # Debugging step: echo the variables to confirm they are set
      ExecStartPre = ''
        if [ -z "$SYNCTHING_SCHWEIZ_ID" ]; then
          echo "Error: SYNCTHING_SCHWEIZ_ID is not set" >> /var/log/syncthing-debug.log
        else
          echo "SYNCTHING_SCHWEIZ_ID=$SYNCTHING_SCHWEIZ_ID" >> /var/log/syncthing-debug.log
        fi

        if [ -z "$SYNCTHING_SALZBURG_ID" ]; then
          echo "Error: SYNCTHING_SALZBURG_ID is not set" >> /var/log/syncthing-debug.log
        else
          echo "SYNCTHING_SALZBURG_ID=$SYNCTHING_SALZBURG_ID" >> /var/log/syncthing-debug.log
        fi
      '';
    };
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui.address = "127.0.0.1:8384";
    extraFlags = [
      "--no-browser"
      "--gui-address=127.0.0.1:8384"
      "--config=/home/simon/.config/syncthing"
      "--data=/home/simon/"
    ];
  };
}
