{
  config,
  pkgs,
  lib,
  ...
}: let
  secrets = import ./../env.nix; # Import the .nix file
in {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui.address = "127.0.0.1:8384";
    settings.folders = {
      "Documents" = {
        path = "/home/simon/Documents";
        devices = ["schweiz" "salzburg"];
      };
    };
    settings.devices = {
      "schweiz" = {
        id = secrets.SYNCTHING_SCHWEIZ_ID;
        name = "Schweiz";
      };
      "salzburg" = {
        id = secrets.SYNCTHING_SALZBURG_ID;
        name = "Salzburg";
      };
    };
  };

  # Override the default Syncthing ExecStart
  systemd.services.syncthing.serviceConfig.ExecStart = lib.mkForce ''
    /nix/store/gd7qhh4xvxnm5mpkxf4hqi0x9xa2ln2l-syncthing-1.27.7/bin/syncthing \
      -no-browser \
      -gui-address=127.0.0.1:8384 \
      -config=/var/lib/syncthing/.config/syncthing \
      -data=/var/lib/syncthing
  '';

  # Example: Inject environment variables into Syncthing
  systemd.services.syncthing.environment = {
    SYNCTHING_SCHWEIZ_ID = "${config.sops.secrets."SYNCTHING_SCHWEIZ_ID".path}";
    SYNCTHING_SALZBURG_ID = "${config.sops.secrets."SYNCTHING_SALZBURG_ID".path}";
  };
}
