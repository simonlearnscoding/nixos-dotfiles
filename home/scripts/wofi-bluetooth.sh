#!/usr/bin/env bash

# Dependencies: bluetoothctl, wofi, notify-send
# Make executable: chmod +x ~/.local/bin/wofi-bluetooth

style="/home/simon/nixos-dotfiles/home/configfiles/wofi/src/macchiato/style.css"

# Build the menu: power toggle, scan, and paired devices
chosen=$(echo -e " Toggle Power\n Scan\n$(bluetoothctl devices Paired | sed 's/Device //' )" \
  | wofi --style "$style" --dmenu --prompt "Bluetooth" --cache-file=/dev/null)

# Exit if nothing was chosen
[ -z "$chosen" ] && exit 0

case "$chosen" in
  " Toggle Power")
    if bluetoothctl show | grep -q "Powered: yes"; then
      bluetoothctl power off
      notify-send "Bluetooth" "Powered off"
    else
      bluetoothctl power on
      notify-send "Bluetooth" "Powered on"
    fi
    ;;

  " Scan")
    bluetoothctl scan on &
    sleep 5
    bluetoothctl scan off
    devices=$(bluetoothctl devices | sed 's/Device //')
    chosen_dev=$(echo "$devices" \
      | wofi --style "$style" --dmenu --prompt "Pair/Connect" --cache-file=/dev/null)
    if [ -n "$chosen_dev" ]; then
      mac=${chosen_dev%% *}
      bluetoothctl pair "$mac"
      bluetoothctl connect "$mac"
      notify-send "Bluetooth" "Connected to $(echo "$chosen_dev" | cut -d' ' -f2-)"
    fi
    ;;

  *)
    mac=$(echo "$chosen" | awk '{print $1}')
    name=$(echo "$chosen" | cut -d' ' -f2-)
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
      bluetoothctl disconnect "$mac"
      notify-send "Bluetooth" "Disconnected from $name"
    else
      bluetoothctl connect "$mac"
      notify-send "Bluetooth" "Connected to $name"
    fi
    ;;
esac
