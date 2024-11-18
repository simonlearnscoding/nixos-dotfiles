{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui = {
      address = "127.0.0.1:8384"; # Syncthing Web GUI address
    };
  };
}
