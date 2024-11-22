{ config, pkgs, ... }:

let
  batteryMonitorScript = ''
    #!/usr/bin/env bash

    # Warning levels
    LOW_BATTERY=20
    CRITICAL_BATTERY=15

    while true; do
        # Get the battery percentage
        BATTERY_LEVEL=$(upower -i $(upower -e | grep battery) | grep percentage | awk '{print $2}' | sed 's/%//')
        BATTERY_STATE=$(upower -i $(upower -e | grep battery) | grep state | awk '{print $2}')

        if [[ "$BATTERY_STATE" == "discharging" ]]; then
            if [[ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY" ]]; then
                notify-send -u critical "Battery Critical" "Battery is at ${BATTERY_LEVEL}%. Please plug in the charger."
                paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
                sleep 10
            elif [[ "$BATTERY_LEVEL" -le "$LOW_BATTERY" ]]; then
                notify-send -u normal "Low Battery" "Battery is at ${BATTERY_LEVEL}%. Consider plugging in the charger."
                sleep 60
            fi
        fi

        sleep 30
    done
  '';
in {
  options = {
    services.batteryMonitor.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the battery monitor service.";
    };
  };

  config = lib.mkIf config.services.batteryMonitor.enable {
    # Ensure required tools are installed through Home Manager
    home.packages = with pkgs; [
      libnotify  # For `notify-send`
      alsa-utils # For `paplay`
      upower     # For battery status
      gawk       # For `awk`
    ];

    # Write the battery monitor script to `/etc`
    environment.etc."battery-monitor.sh".text = batteryMonitorScript;

    # Systemd service
    systemd.services.battery-monitor = {
      description = "Battery Monitor";
      after = [ "graphical.target" ];
      wantedBy = [ "default.target" ];

      serviceConfig = {
        ExecStart = "/etc/battery-monitor.sh";
        Restart = "always";
      };

      # Optional: Run as a specific user
      user = config.users.users.your-username.name; # Replace this with a real username if necessary
    };
  };
}
