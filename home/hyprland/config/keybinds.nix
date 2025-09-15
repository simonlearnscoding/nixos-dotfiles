# keybindings.nix
{pkgs, ...}: let
  mainMod = "Super"; # Define Super as the main mod key
in {
  wayland.windowManager.hyprland.settings.bindm = [
    "${mainMod}, mouse:272, movewindow" # drag window with Super + LMB
    "${mainMod}, mouse:273, resizewindow" # resize window with Super + RMB
  ];

  wayland.windowManager.hyprland.settings.bindel = [
    ", F2, exec, swayosd-client --output-volume lower" # lower volume (F2)
    ", F3, exec, swayosd-client --output-volume raise" # raise volume (F3)
    ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower" # lower volume (key)
    ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise" # raise volume (key)
    ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise" # increase brightness
    ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower" # decrease brightness
  ];

  wayland.windowManager.hyprland.settings.bind = [
    "${mainMod}, mouse_down, workspace, e+1" # switch workspace down
    "${mainMod}, mouse_up, workspace, e-1" # switch workspace up
    "${mainMod}, Q, exec, hyprctl dispatch killactive" # close focused window
    "${mainMod}, O, exec, /home/simon/nixos-dotfiles/home/scripts/wofi-notes" # open wofi notes
    "${mainMod}, V, exec, neovide" # open Neovide
    "${mainMod}, D, overview:toggle" # toggle overview
    "${mainMod}, delete, exit" # exit Hyprland
    "${mainMod}, G, togglefloating" # toggle floating mode
    "${mainMod}, W, exec, waypaper" # wallpaper chooser
    "${mainMod}, M, fullscreen" # toggle fullscreen
    "${mainMod}, RETURN, exec, /home/simon/nixos-dotfiles/home/scripts/wofi.sh" # open wofi menu
    "${mainMod}, TAB, exec, /home/simon/nixos-dotfiles/home/scripts/restore.sh" # restore minimized
    "${mainMod}, N, exec, /home/simon/nixos-dotfiles/home/scripts/minimize.sh" # minimize window
    "ALT, return, fullscreen" # toggle fullscreen (Alt+Enter)
    "${mainMod}, T, exec, kitty" # open Kitty terminal
    "${mainMod}, F, exec, nautilus" # open Nautilus
    "${mainMod} SHIFT, F, exec, /home/simon/nixos-dotfiles/scripts/wofi-dir-script.sh" # open wofi file picker
    "${mainMod}, B, exec, firefox" # open Firefox
    "${mainMod}, SPACE, exec, /home/simon/scripts/toggle-wk.sh" # toggle workspaces
    "${mainMod}, a, exec, pkill -x rofi ; rofi -show window" # open Rofi window switcher
    "${mainMod}, ESCAPE, exec, pkill -x rofi ; rofi -show window" # open Rofi window switcher
    "${mainMod}, e, exec, pkill -x rofi ; rofi -show drun" # open Rofi app launcher
    ", F1, exec, swayosd-client --output-volume mute-toggle" # mute/unmute volume
    ", F4, exec, swayosd-client --input-volume mute-toggle" # mute/unmute mic (F4)
    ", 190, exec, swayosd-client --input-volume mute-toggle" # mute/unmute mic (code 190)
    ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle" # mute volume key
    ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle && ~/nixos-dotfiles/home/scripts/toggle-mic-mute-led.sh" # mic mute toggle w/ LED
    ", XF86AudioPlay, exec, playerctl play-pause" # play/pause media
    ", XF86AudioPause, exec, playerctl play-pause" # pause media
    ", XF86AudioNext, exec, playerctl next" # next track
    ", XF86AudioPrev, exec, playerctl previous" # previous track
    "${mainMod}, P, exec, pin" # take screenshot (pin)
    "${mainMod} SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy" # area screenshot to clipboard
    "${mainMod}, H, movefocus, l" # move focus left
    "${mainMod}, K, movefocus, u" # move focus up
    "${mainMod}, J, movefocus, d" # move focus down
    "${mainMod}, L, movefocus, r" # move focus right
    "${mainMod}, left, movefocus, l" # move focus left (arrow)
    "${mainMod}, up, movefocus, u" # move focus up (arrow)
    "${mainMod}, down, movefocus, d" # move focus down (arrow)
    "${mainMod}, right, movefocus, r" # move focus right (arrow)
    "ALT, Tab, movefocus, d" # Alt+Tab focus down
    "${mainMod}, 1, workspace, 1" # switch to workspace 1
    "${mainMod}, 2, workspace, 2" # switch to workspace 2
    "${mainMod}, 3, workspace, 3" # switch to workspace 3
    "${mainMod}, 4, workspace, 4" # switch to workspace 4
    "${mainMod}, 5, workspace, 5" # switch to workspace 5
    "${mainMod}, 6, workspace, 6" # switch to workspace 6
    "${mainMod}, 7, workspace, 7" # switch to workspace 7
    "${mainMod}, 8, workspace, 8" # switch to workspace 8
    "${mainMod}, 9, workspace, 9" # switch to workspace 9
    "${mainMod}, 0, workspace, 10" # switch to workspace 10
    "${mainMod}Shift, 1, movetoworkspace, 1" # move window to workspace 1
    "${mainMod}Shift, 2, movetoworkspace, 2" # move window to workspace 2
    "${mainMod}Shift, 3, movetoworkspace, 3" # move window to workspace 3
    "${mainMod}Shift, 4, movetoworkspace, 4" # move window to workspace 4
    "${mainMod}Shift, 5, movetoworkspace, 5" # move window to workspace 5
    "${mainMod}Shift, 6, movetoworkspace, 6" # move window to workspace 6
    "${mainMod}Shift, 7, movetoworkspace, 7" # move window to workspace 7
    "${mainMod}Shift, 8, movetoworkspace, 8" # move window to workspace 8
    "${mainMod}Shift, 9, movetoworkspace, 9" # move window to workspace 9
    "${mainMod}Shift, 0, movetoworkspace, 10" # move window to workspace 10
    "${mainMod} CTRL, j, workspace, r+1" # next relative workspace
    "${mainMod} CTRL, k, workspace, r-1" # prev relative workspace
    "${mainMod} CTRL, right, workspace, r+1" # next relative workspace (arrow)
    "${mainMod} CTRL, left, workspace, r-1" # prev relative workspace (arrow)
    "${mainMod} CTRL, down, workspace, empty" # go to empty workspace
    "${mainMod} CONTROL ALT, l, resizeactive, 30 0" # resize +30px right
    "${mainMod} CONTROL ALT, h, resizeactive, -30 0" # resize -30px left
    "${mainMod} CONTROL ALT, k, resizeactive, 0 -30" # resize -30px up
    "${mainMod} CONTROL ALT, j, resizeactive, 0 30" # resize +30px down
    "${mainMod} CONTROL ALT, right, resizeactive, 30 0" # resize +30px right (arrow)
    "${mainMod} CONTROL ALT, left, resizeactive, -30 0" # resize -30px left (arrow)
    "${mainMod} CONTROL ALT, up, resizeactive, 0 -30" # resize -30px up (arrow)
    "${mainMod} CONTROL ALT, down, resizeactive, 0 30" # resize +30px down (arrow)
    "${mainMod} SHIFT, h, movewindoworgroup, l" # move window/group left
    "${mainMod} SHIFT, l, movewindoworgroup, r" # move window/group right
    "${mainMod} ALT, S, movetoworkspacesilent, special" # send window silently to special ws
    "${mainMod}, o, togglesplit," # toggle split layout
    "${mainMod} SHIFT, j, movetoworkspace, +1" # move window to next workspace
    "${mainMod} SHIFT, k, movetoworkspace, -1" # move window to previous workspace
    "${mainMod} ALT, 1, movetoworkspacesilent, 1" # move silently to ws 1
    "${mainMod} ALT, 2, movetoworkspacesilent, 2" # move silently to ws 2
    "${mainMod} ALT, 3, movetoworkspacesilent, 3" # move silently to ws 3
    "${mainMod} ALT, 4, movetoworkspacesilent, 4" # move silently to ws 4
    "${mainMod} ALT, 5, movetoworkspacesilent, 5" # move silently to ws 5
    "${mainMod} ALT, 6, movetoworkspacesilent, 6" # move silently to ws 6
    "${mainMod} ALT, 7, movetoworkspacesilent, 7" # move silently to ws 7
    "${mainMod} ALT, 8, movetoworkspacesilent, 8" # move silently to ws 8
    "${mainMod} ALT, 9, movetoworkspacesilent, 9" # move silently to ws 9
    "${mainMod} ALT, 0, movetoworkspacesilent, 10" # move silently to ws 10
    ", switch:on:Lid Switch, exec, swaylock && systemctl suspend" # lock + suspend on lid close
    "${mainMod} CTRL, w, movetoworkspace, special" # move to special workspace
  ];
}
