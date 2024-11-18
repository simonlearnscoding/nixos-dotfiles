{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open 22000/TCP and 21027/UDP in the firewall
    settings.gui = {
      address = "127.0.0.1:8384"; # Syncthing Web GUI address
    };
  };
}
