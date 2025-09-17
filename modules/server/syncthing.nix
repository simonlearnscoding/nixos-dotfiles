{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services.syncthing = {
    after = ["mnt-drive.mount"];
    requires = ["mnt-drive.mount"];
    bindsTo = ["mnt-drive.mount"];
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/mnt/drive";
    configDir = "/mnt/drive/syncthing-config";
    user = "simon";

    # GUI only available locally
    guiAddress = "0.0.0.0:8384";

    # Hardening: rely only on Tailscale, disable WAN/LAN discovery
    settings.options = {
      natEnabled = false;
      globalAnnounceEnabled = false;
      localAnnounceEnabled = false;
      relayEnabled = false;
    };

    declarative = {
      overrideDevices = false;
      overrideFolders = false;

      devices = {
        fabio-pc = {
          id = "MMRJWPX-7YX3TQW-OCVPOQL-2IP22QH-SJLAXIE-A3AGC7C-3546S6L-ZVQGUQP";
          name = "fabio-pc";
        };
        server-salzburg = {
          id = "IL3DCZS-4ASMHNV-UJ654ZK-BEL5LFU-5AVY764-BHTRCVL-THGBZPH-ZIAKVAJ";
          name = "server-salzburg";
        };

        fabio-laptop-lenovo = {
          id = "4ZLQ5YQ-LHX6M7G-MQHQEOL-QWLZSFQ-KOIYB5F-NDPYLWB-PLCJEGF-CDT6PAI";
          name = "fabio-laptop-lenovo";
        };
      };
      # Example folders (uncomment + adjust paths/devices to use):
      folders = {
        documents = {
          path = "/mnt/drive/syncthing/fabio/documents";
          devices = ["server-salzburg" "fabio-pc" "fabio-laptop-lenovo"];
          versioning = {
            type = "trashcan";
          };
        };
      };
    };
  };
}
