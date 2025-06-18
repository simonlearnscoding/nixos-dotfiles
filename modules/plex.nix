{pkgs, ...}: {
  services.plex = {
    enable = false;
    dataDir = "/var/lib/plex"; # Default directory for Plex data (can be customized).
    user = "plex"; # User to run the Plex Media Server as.
    group = "plex"; # Group to run the Plex Media Server as.
    # claimToken = "claim-xX4WVzNGgufzLw7V6hPs";
  };
  services.jellyfin = {
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/home/simon/drive/media-config/jellyfin";
  };

  # needed for hardware acc

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  users.users.simon.extraGroups = ["video"];
  # make sure jellyfin has access to this one

  systemd.tmpfiles.rules = [
    "d /home/simon/drive/media-config/jellyfin 0755 simon users -"
  ];

  # SONARR RADARR AND SO ON
  services.radarr = {
    # port 7878
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/home/simon/drive/media-config/radarr";
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    port = 12345;
  };

  # needed because sonarr relies on this one
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-6.0.428"
  ];
  services.jackett = {
    enable = false;
    # user = "simon";
    # group = "users";
    # dataDir = "/home/simon/drive/media-config/jackett";
    # port = 1440;
  };

  services.prowlarr = {
    enable = true;
  };
  # for series
  services.sonarr = {
    # port 8989
    enable = true;
    user = "simon";
    group = "users";
    dataDir = "/home/simon/drive/media-config/sonarr";
  };

  # to download subtitles
  services.bazarr = {
    enable = true;
    listenPort = 6768;
    group = "users";
    user = "simon";
  };
  services.deluge = {
    web.port = 8112;
    web.enable = true;
    enable = true;
    user = "simon";
    group = "users";
  };
  # NEXTCLOUD
  environment.etc."nextcloud-admin-pass".text = "ThePassword";
  services.nextcloud = {
    package = pkgs.nextcloud30;
    enable = true;
    hostName = "localhost";
    configureRedis = true;
    database.createLocally = true;
    config = {
      adminuser = "admin";
      dbtype = "mysql";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };

  # DASHBOARD
  # services.heimdall = {
  #   enable = true;
  #   port = 8088;
  # };

  services.nginx = {
    enable = false;
  };

  services.caddy = {
    enable = true;

    virtualHosts."overseerr.simone-muscas.com" = {
      extraConfig = ''
        # Required for Plex Web
        reverse_proxy localhost:12345
      '';
    };
    virtualHosts."plex.simone-muscas.com" = {
      extraConfig = ''
        # Required for Plex Web
        reverse_proxy localhost:8096
      '';
    };

    virtualHosts."syncthing.simone-muscas.com" = {
      extraConfig = ''
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
  };
}
