{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services.syncthing = {
    after = ["home-simon-drive.mount"];
  };
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/simon/drive/syncthing";
    configDir = "/home/simon/.config/syncthing";
    user = "simon";
    settings.options.natEnabled = false;
    guiAddress = "0.0.0.0:8384";
    settings.gui.address = "0.0.0.0:8384";

    declarative = {
      overrideDevices = false;
      overrideFolders = false;
      devices = {
        laptop-simon = {id = "G6KK456-XTQAACF-HVCEY6G-LFO3QFR-HPQCOSM-C3KAMFY-O22F3M4-35WCFQN";};
        laptop-fabio = {id = "A5FMV6L-O4JTC7L-WZZ2KIQ-UQHPPHE-VBQ76X3-BV5AMWS-HST4GXM-JJYJQQB";};
      };
      folders = {
        fabio-documents = {
          path = "/home/simon/drive/syncthing/fabio/documents";
          devices = ["laptop-fabio"];
          versioning = {
            type = "simple";
            params = {
              keep = "5";
            };
          };
        };
        simon-documents = {
          path = "/home/simon/drive/syncthing/simon/documents";
          devices = ["laptop-simon"];
          versioning = {
            type = "simple";
            params = {
              keep = "5";
            };
          };
        };
      };
    };
  };
}
