{
  config,
  pkgs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      font-awesome
      jetbrains-mono
      fantasque-sans-mono

      socat # Required for Hyprland workspace events
      jq # For JSON processing
      playerctl
      swaylock
      wlogout
    ];

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 32;
          modules-left = ["hyprland/workspaces"];
          modules-center = [
            "custom/music"
            "clock"
          ];
          modules-right = [
            "pulseaudio"
            "custom/mic"
            "backlight"
            "battery"
            # "tray" # discord and other apps
            "custom/lock"
            "custom/power"
          ];

          "custom/mic" = {
            exec = "${pkgs.pulseaudio}/bin/pactl get-source-mute @DEFAULT_SOURCE@ | ${pkgs.gnugrep}/bin/grep -q 'Mute: no' && echo '' || echo ''";
            interval = 5;
            format = "{}";
            tooltip = false;
            on-click = "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          };
          "hyprland/workspaces" = {
            # Changed from wlr/workspaces to hyprland/workspaces
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              default = "";
              active = "󰮯";
              urgent = "󱔗";
            };
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

          tray = {
            icon-size = 21;
            spacing = 10;
          };

          "custom/music" = {
            format = "  {}";
            escape = true;
            interval = 5;
            tooltip = false;
            exec = "${pkgs.playerctl}/bin/playerctl metadata --format='{{ title }}'";
            on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
            max-length = 50;
          };

          clock = {
            timezone = "Austria/Vienna";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "   {:%d/%m/%Y}";
            interval = 1;
            format = "{:%H:%M:%S}";
          };

          backlight = {
            device = "intel_backlight";
            format = "{icon} ";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-charging = "";
            format-plugged = "";
            format-alt = "{icon}";
            format-icons = ["" "" "" "" ""];
          };

          pulseaudio = {
            format = "{icon}  {volume}%";
            format-muted = "";
            format-icons.default = ["" "" " "];
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };

          "custom/lock" = {
            tooltip = false;
            on-click = "${pkgs.swaylock}/bin/swaylock ";
            format = "";
          };

          "custom/power" = {
            tooltip = false;
            on-click = "${pkgs.wlogout}/bin/wlogout";
            format = "";
          };
        };
      };

      style = ''
                            * {
                              font-family: FantasqueSansMono Nerd Font;
                              font-size: 17px;
                              min-height: 0;
                              margin: 0;
                              padding: 0;
                            }

                            #waybar {
                              background: transparent;
                              color: #cdd6f4;
                              margin: 0;
                              padding: 0;
                              border:none;
                            }


        #workspaces {
            border-radius: 4px;  /* Smaller corner radius */
            background-color: #313244;
            margin: 0 0.25rem;   /* Reduced horizontal margin */
            padding: 2px 0.25rem; /* Top/bottom padding for container */
        }

        #workspaces button {
            color: #b4befe;
            padding: 0.25rem 0.75rem;  /* More compact padding */
            margin: 2px 1px 0 1px;     /* Top margin added */
            transition: all 0.2s ease-in-out;
            border-radius: 3px;        /* Subtle rectangular rounding */
            font-size: 12px;           /* Smaller font size */
        }

        #workspaces button.active {
            color: #89dceb;
            background-color: #45475a;
            box-shadow: none;          /* Remove inset shadow */
            border-bottom: 2px solid #89dceb; /* Bottom border instead */
        }

        #workspaces button.urgent {
            color: #f38ba8;
            background-color: #585b70;
            animation: urgent-flash 1s infinite;
            border-radius: 3px;
        }

        /* Keep existing keyframes */
        @keyframes urgent-flash {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        #custom-mic {
            background-color: #313244;
            padding: 0.25rem 0.75rem;  /* Match workspace button padding */
            margin: 2px 6px 0 0;       /* Adjusted margins */
            color: #eba0ac;            /* Use hex color instead of @maroon */
            border-radius: 3px;        /* Match workspace button radius */
        }

        #custom-mic.muted {
            color: #f38ba8;            /* Use hex color instead of @red */
        }

                            #custom-music,
                            #tray,
                            #backlight,
                            #clock,
                            #battery,
                            #pulseaudio,
                            #custom-lock,
                            #custom-power {
                              background-color: #313244;
                              padding: 0.5rem 1rem;
                              margin: 5px 0;
                            }

                            #clock {
                              color: #89b4fa;
                              border-radius:  1rem ;
                            }

                            #battery {
                              color: #a6e3a1;
                            }

                            #battery.charging {
                              color: #a6e3a1;
                            }

                            #battery.warning:not(.charging) {
                              color: #f38ba8;
                            }

                            #backlight {
                              color: #f9e2af;
                            }

                            #backlight, #battery {
                                border-radius: 0;
                            }

                            #pulseaudio {
                              color: #eba0ac;
                              border-radius: 1rem ;
                              margin-right: 4px;
                            }

                            #custom-music {
                              color: #cba6f7;
                              border-radius: 1rem;
                            }

                            #custom-lock {
                                border-radius: 1rem 0px 0px 1rem;
                                color: #b4befe;
                            }

                            #custom-power {
                                margin-right: 1rem;
                                border-radius: 0px 1rem 1rem 0px;
                                color: #f38ba8;
                            }

                            #tray {
                              margin-right: 1rem;
                              border-radius: 1rem;
                            }
      '';
    };

    wayland.windowManager.hyprland.extraConfig = ''
      bind = $mainMod, F5, exec, ${pkgs.procps}/bin/pkill waybar && ${pkgs.waybar}/bin/waybar
    '';
  };
}
