{
  pkgs,
  lib,
  ...
}: let
  # Helper: make services depend on external drive
  # - after    → wait until drive is mounted
  # - requires → service won't start if drive is missing
  # - bindsTo  → if drive unmounts, service stops
  needsDrive = {
    after = ["mnt-drive.mount"];
    requires = ["mnt-drive.mount"];
    bindsTo = ["mnt-drive.mount"];
  };

  # Helper: generic proxy snippet for most services
  mkProxy = port: ''
    reverse_proxy localhost:${toString port}
  '';

  # Special case: Jellyfin proxy (needs real client headers)
  jellyfinProxy = ''
    reverse_proxy localhost:8096 {
      header_up X-Real-IP {remote_host}
      header_up X-Forwarded-For {remote_host}
      header_up X-Forwarded-Proto {scheme}
    }
  '';
in {
  ##########################
  ## Media Services
  ##########################

  # Plex is disabled (still points to default location)
  services.plex.enable = false;

  # Jellyfin media server
  services.jellyfin = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/mnt/drive/media-config/jellyfin";
  };

  # Radarr (movies)
  services.radarr = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/mnt/drive/media-config/radarr";
  };

  # Sonarr (TV series)
  services.sonarr = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/mnt/drive/media-config/sonarr";
  };

  # Bazarr (subtitles)
  services.bazarr = {
    enable = true;
    listenPort = 6768;
    user = "simon";
    group = "users";
  };

  # Prowlarr (indexer manager)
  services.prowlarr.enable = true;

  # Deluge torrent client (with web UI)
  services.deluge = {
    enable = true;
    user = "simon";
    group = "users";
    web.enable = true;
    web.port = 8112;
  };

  # Jellyseerr (requests for Jellyfin/Plex)
  services.jellyseerr = {
    enable = true;
    openFirewall = true; # allow LAN access to web UI
    port = 12345;
  };

  # Jackett (indexer) is currently disabled
  services.jackett = {
    enable = false;
    # dataDir = "/mnt/drive/media-config/jackett";
  };

  # Sonarr requires old insecure .NET runtimes → whitelist them
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-6.0.428"
  ];

  ##########################
  ## Filesystem Integration
  ##########################

  # Ensure config directories exist on the external drive
  systemd.tmpfiles.rules = [
    "d /mnt/drive/media-config/jellyfin 0755 simon users -"
    "d /mnt/drive/media-config/radarr 0755 simon users -"
    "d /mnt/drive/media-config/sonarr 0755 simon users -"
  ];

  # Make services depend on the external drive
  systemd.services = {
    jellyfin = needsDrive;
    radarr = needsDrive;
    sonarr = needsDrive;
    bazarr = needsDrive;
    deluge = needsDrive;
    syncthing = needsDrive; # not configured here, but tied to drive
  };

  ##########################
  ## Reverse Proxy (Caddy)
  ##########################

  # Disable nginx → only use Caddy
  services.nginx.enable = false;

  services.caddy = {
    enable = true;

    virtualHosts = {
      # Media apps on subdomains
      "jellyfin.simone-muscas.com".extraConfig = jellyfinProxy;
      "radarr.simone-muscas.com".extraConfig = mkProxy 7878;
      "sonarr.simone-muscas.com".extraConfig = mkProxy 8989;
      "bazarr.simone-muscas.com".extraConfig = mkProxy 6768;
      "prowlarr.simone-muscas.com".extraConfig = mkProxy 9696;
      "deluge.simone-muscas.com".extraConfig = mkProxy 8112;
      "overseerr.simone-muscas.com".extraConfig = mkProxy 12345;

      # Plex proxy exists, but Plex service itself is disabled
      "plex.simone-muscas.com".extraConfig = mkProxy 8096;
    };
  };

  # Only open web ports to the outside
  networking.firewall.allowedTCPPorts = [80 443];
}
