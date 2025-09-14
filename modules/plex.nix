{
  pkgs,
  lib,
  ...
}: let
  # Helper function that makes a service depend on the external drive.
  # - after   → start only after the drive is mounted
  # - requires → service won’t start if the drive is missing
  # - bindsTo  → if the drive is unmounted, the service is stopped automatically
  needsDrive = {
    after = ["mnt-drive.mount"];
    requires = ["mnt-drive.mount"];
    bindsTo = ["mnt-drive.mount"];
  };
in {
  # Plex (disabled here, still points to default /var/lib/plex)
  services.plex.enable = false;

  # Jellyfin media server (runs as your user `simon`, stores data on external drive)
  services.jellyfin = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/mnt/drive/media-config/jellyfin";
  };

  # Enable hardware video acceleration (Intel iGPU)
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [intel-media-driver];
  };

  # Give `simon` access to the video group for HW acceleration
  users.users.simon.extraGroups = ["video"];

  # Make sure required directories exist on the external drive
  systemd.tmpfiles.rules = [
    "d /mnt/drive/media-config/jellyfin 0755 simon users -"
    "d /mnt/drive/media-config/radarr 0755 simon users -"
    "d /mnt/drive/media-config/sonarr 0755 simon users -"
  ];

  # Radarr (movie manager)
  services.radarr = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/mnt/drive/media-config/radarr";
  };

  # Jellyseerr (requests manager for Jellyfin/Plex)
  services.jellyseerr = {
    enable = true;
    openFirewall = true; # open firewall for web UI
    port = 12345;
  };

  # Needed because Sonarr uses these older .NET runtimes (marked insecure)
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-6.0.428"
  ];

  # Jackett (torrent indexer, currently disabled)
  services.jackett = {
    enable = false;
    # dataDir = "/mnt/drive/media-config/jackett";
  };

  # Prowlarr (indexer manager for Sonarr/Radarr/etc.)
  services.prowlarr.enable = true;

  # Sonarr (TV series manager)
  services.sonarr = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/mnt/drive/media-config/sonarr";
  };

  # Bazarr (subtitle downloader)
  services.bazarr = {
    enable = true;
    listenPort = 6768;
    user = "simon";
    group = "users";
  };

  # Deluge (torrent client with web UI)
  services.deluge = {
    enable = true;
    user = "simon";
    group = "users";
    web.enable = true;
    web.port = 8112;
  };

  # Nginx is disabled since we use Caddy instead
  services.nginx.enable = false;

  # Caddy reverse proxy (HTTPS out of the box, simple config)
  services.caddy = {
    enable = true;

    # Overseerr → overseerr.simone-muscas.com
    virtualHosts."overseerr.simone-muscas.com".extraConfig = ''
      reverse_proxy localhost:12345
    '';

    # Plex (proxied through 8096, though Plex service is disabled above)
    virtualHosts."plex.simone-muscas.com".extraConfig = ''
      reverse_proxy localhost:8096
    '';

    # Syncthing web UI (with headers and TLS tweaks)
    virtualHosts."syncthing.simone-muscas.com".extraConfig = ''
      reverse_proxy localhost:8384 {
        transport http {
          tls_insecure_skip_verify
        }
        header_up Host {host}
        header_up X-Real-IP {remote}
        header_up X-Forwarded-For {remote}
        header_up X-Forwarded-Proto {scheme}
      }
    '';
  };

  # Apply the external drive dependency to all important services.
  # These will:
  # - start only if /mnt/drive is mounted
  # - stop automatically if /mnt/drive is unmounted
  systemd.services = {
    jellyfin = needsDrive;
    radarr = needsDrive;
    syncthing = needsDrive;
    sonarr = needsDrive;
    bazarr = needsDrive;
    deluge = needsDrive;
  };
}
