{lib, ...}: let
  # Generic proxy
  mkProxy = port: ''
    reverse_proxy localhost:${toString port}
  '';

  # Special case for Jellyfin (needs forwarded headers)
  jellyfinProxy = ''
    reverse_proxy localhost:8096 {
      header_up X-Real-IP {remote_host}
      header_up X-Forwarded-For {remote_host}
      header_up X-Forwarded-Proto {scheme}
    }
  '';
in {
  services.nginx.enable = false;

  services.caddy = {
    enable = true;

    virtualHosts = {
      "jellyfin.simone-muscas.com".extraConfig = jellyfinProxy;
      "radarr.simone-muscas.com".extraConfig = mkProxy 7878;
      "sonarr.simone-muscas.com".extraConfig = mkProxy 8989;
      "bazarr.simone-muscas.com".extraConfig = mkProxy 6768;
      "prowlarr.simone-muscas.com".extraConfig = mkProxy 9696;
      "deluge.simone-muscas.com".extraConfig = mkProxy 8112;
      "overseerr.simone-muscas.com".extraConfig = mkProxy 12345;
      "plex.simone-muscas.com".extraConfig = jellyfinProxy;
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
