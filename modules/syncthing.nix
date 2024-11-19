{config, ...}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui.address = "127.0.0.1:8384";

    # Use extraFlags to pass arguments
    extraFlags = [
      "--no-browser"
      "--gui-address=127.0.0.1:8384"
      "--config=/var/lib/syncthing/.config/syncthing"
      "--data=/var/lib/syncthing"
    ];
    devices = {
      "salzburg-server" = {id = SYNCTHING_SALZBURG_ID;};
      "schweiz-server" = {id = SYNCTHING_SCHWEIZ_ID;};
    };

    # Inject secrets via environment variables
  };

  # Example: Inject environment variables into Syncthing
  systemd.services.syncthing.environment = {
    SYNCTHING_SCHWEIZ_ID = "${config.sops.secrets."SYNCTHING_SCHWEIZ_ID".path}";
    SYNCTHING_SALZBURG_ID = "${config.sops.secrets."SYNCTHING_SALZBURG_ID".path}";
  };
}
