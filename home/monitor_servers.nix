
{...}:
{systemd.services.url-monitor = {
  description = "Monitor URLs for availability";
  wantedBy = [ "multi-user.target" ]; # Start the service normally if needed
  serviceConfig = {
    ExecStart = "./scripts/monitor_servers.sh";
    Restart = "on-failure";
    RestartSec = 5s;
  };
};

systemd.timers.url-monitor = {
  description = "Timer to run URL monitor script every 5 minutes";
  wantedBy = [ "timers.target" ]; # Starts the timer on boot
  timerConfig = {
    OnBootSec = "1min";       # Start 1 minute after boot
    OnUnitActiveSec = "5min"; # Run every 5 minutes
  };
};
}
