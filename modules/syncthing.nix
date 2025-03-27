{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services.syncthing = {
    serviceConfig.User = lib.mkForce "simon";
    # Inject secrets as environment variables
    # environment = {
    #   SYNCTHING_SCHWEIZ_ID = ''${config.sops.secrets."SYNCTHING_SCHWEIZ_ID".path}'';
    #   SYNCTHING_SALZBURG_ID = ''${config.sops.secrets."SYNCTHING_SALZBURG_ID".path}'';
    # };
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui.address = "0.0.0.0:8384";
    extraFlags = [
      "--no-browser"
      "--gui-address=127.0.0.1:8384"
      "--config=/home/simon/.config/syncthing"
      "--data=/home/simon/"
    ];
  };
}
# I gave up on trying to set this up with secrets
# settings.devices = {
#   "schweiz-server" = {
#     id = "${config.sops.secrets."SYNCTHING_SCHWEIZ_ID".path}";
#     name = "schweiz-server";
#   };
#
#   "salzburg-server" = {
#     id = "${config.sops.secrets."SYNCTHING_SCHWEIZ_ID".path}";
#     name = "schweiz-server";
#   };
# Inject secrets via environment variables
# Example: Inject environment variables into Syncthing
# systemd.services.syncthing.environment = {
#   SYNCTHING_SCHWEIZ_ID = "${config.sops.secrets."SYNCTHING_SCHWEIZ_ID".path}";
#   SYNCTHING_SALZBURG_ID = "${config.sops.secrets."SYNCTHING_SALZBURG_ID".path}";
# };

