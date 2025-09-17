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
      globalAnnounceEnabled = true;
      localAnnounceEnabled = true;
      relayEnabled = false;
    };

    declarative = {
      overrideDevices = true;
      overrideFolders = true;

      devices = {
        fabio-pc = {
          id = "YNYJV2K-UTS3MTJ-RTVBJ44-EZAC7QB-2GI3Y3P-VIKKUVO-N4OLOUF-5AEHJQO";
          name = "fabio-pc";
        };
        server-salzburg = {
          id = "IL3DCZS-4ASMHNV-UJ654ZK-BEL5LFU-5AVY764-BHTRCVL-THGBZPH-ZIAKVAJ";
          name = "server-salzburg";
        };

        fabio-laptop-lenovo = {
          id = "G6JHDK7-K7AB5YJ-JXUGO7K-QH4OEVF-IGB7Q6R-2WCTX2D-IBYV4I2-MBZXNQA";
          name = "fabio-laptop-lenovo";
        };
      };
      # Example folders (uncomment + adjust paths/devices to use):
      folders = {
        "fabio-documents" = {
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
