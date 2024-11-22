
#!/usr/bin/env bash

# Warning levels
LOW_BATTERY=10
CRITICAL_BATTERY=5

while true; do
    # Get the battery percentage
    BATTERY_LEVEL=$(upower -i $(upower -e | grep battery) | grep percentage | awk '{print $2}' | sed 's/%//')
    BATTERY_STATE=$(upower -i $(upower -e | grep battery) | grep state | awk '{print $2}')

    if [[ "$BATTERY_STATE" == "discharging" ]]; then
        if [[ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY" ]]; then
            notify-send -u critical "Battery Critical" "Battery is at ${BATTERY_LEVEL}%. Please plug in the charger."
            paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga  # Replace with the path to your desired sound
            sleep 10  # Repeat every 10 seconds for critical battery
        elif [[ "$BATTERY_LEVEL" -le "$LOW_BATTERY" ]]; then
            notify-send -u normal "Low Battery" "Battery is at ${BATTERY_LEVEL}%. Consider plugging in the charger."
            sleep 60  # Check again in 1 minute
        fi
    fi

    sleep 30  # Check battery status every 30 seconds
done
