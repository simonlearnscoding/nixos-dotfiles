{pkgs, ...}: {
  home.packages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;

    openDefaultPorts = true;
    settings.gui = {
      address = "127.0.0.1:8384";
    };
  };
}
