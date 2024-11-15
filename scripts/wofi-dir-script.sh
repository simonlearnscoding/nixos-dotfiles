
#!/bin/bash

# Get the list of directories from zoxide
DIR=$(zoxide query -l | wofi --show dmenu --prompt "Select directory:")

# Check if a directory was selected
if [ -n "$DIR" ]; then
  # Open the selected directory with Nautilus
  nautilus "$DIR"
fi
