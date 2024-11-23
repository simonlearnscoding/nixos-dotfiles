
{ config, pkgs, ... }:

{
  systemd.user.services.url-monitor = {
    Unit = {
    Description = "Monitor URLs for availability";
    };
    Install = {
      WantedBy = [ "default.target" ]; # For user-level systemd service
    };
    Service = {
  ExecStart = "${config.home.homeDirectory}/nixos-dotfiles/home/scripts/monitor_servers.sh";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  systemd.user.timers.url-monitor = {
    Unit = {
    Description = "Timer to run URL monitor script every 5 minutes";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
    timerConfig = {
      OnBootSec = "1min";       # Start 1 minute after boot
      OnUnitActiveSec = "5min"; # Run every 5 minutes
    };
  };
}
