{pkgs, ...}: {
  home.packages = with pkgs; [
    hypridle
  ];
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
    }

    # Lock the screen
    listener {
        timeout = 300
        on-timeout = loginctl lock-session
    }

    # Turn off screen
    listener {
        timeout = 320
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }

    # Suspend the system
    listener {
        timeout = 900
        on-timeout = systemctl suspend
    }
  '';
}
