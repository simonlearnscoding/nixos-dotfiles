{
  config,
  lib,
  pkgs,
  ...
}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/simon/Sync";
    configDir = "/home/simon/.config/syncthing";
    user = "simon";
    settings.options.natEnabled = false;
    guiAddress = "0.0.0.0:8384";
    settings.gui.address = "0.0.0.0:8384";
    # extraFlags = [
    #   "--no-browser"
    #   "--gui-address=0.0.0.1:8384"
    #   #   "--config=/home/simon/.config/syncthing"
    #   #   "--data=/home/simon/"
    # ];
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

