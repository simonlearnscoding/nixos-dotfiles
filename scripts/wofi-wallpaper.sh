
#!/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/nixos-dotfiles/files/wallpapers"



# Start wofi and sxiv/feh side by side
selected_wallpaper=$(find "$WALLPAPER_DIR" -type f | while read -r wallpaper; do
    # Show a preview in sxiv or feh in a floating window
    pkill sxiv feh  # Close the previous preview
    sxiv -g 300x300+0+0 "$wallpaper" &  # Adjust size and position as needed
    echo "$wallpaper"
done | wofi --show dmenu --prompt "Select a wallpaper")

# Kill the preview once the selection is done
pkill sxiv feh

# Set the selected wallpaper if it exists
if [ -n "$selected_wallpaper" ]; then
    swww img "$selected_wallpaper"
fi
