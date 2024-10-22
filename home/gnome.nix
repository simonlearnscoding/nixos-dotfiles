{lib, ...}: let
# TODO: I could replace this with env vars probably
  wallpaper = ./../files/wallpapers/wallpaper.jpg;
in
  with lib.hm.gvariant; {
    imports = [
      ./pop-shell.nix
#     ./flameshot.nix
    ];

    dconf.settings = {

      "org/gnome/desktop/interface" = {
        # "cursor-theme" = "Yaru";
        "font-name" = "Roboto 11";
        "icon-theme" = "Tela-circle-dark";
        "color-scheme" = "prefer-dark";
        "document-font-name" = "Roboto 11";
        "enable-animations" = true;
        "enable-hot-corners" = false;
        "font-antialiasing" = "grayscale";
        "font-hinting" = "slight";
        "monospace-font-name" = "MesloLGS Nerd Font Mono 13";
        "show-battery-percentage" = true;
        "toolkit-accessibility" = false;
      };

      "org/gnome/tweaks" = {
        "show-extensions-notice" = false;
      };

      "org/gtk/gtk4/settings/color-chooser" = {
        "custom-colors" = [(mkTuple [0.74901962280273438 0.7450980544090271 0.7764706015586853 1.0])];
        "selected-color" = mkTuple [true 0.87058824300765991 0.86666667461395264 0.85490196943283081 1.0];
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        "show-hidden" = true;
      };

      "org/gtk/settings/file-chooser" = {
        "date-format" = "regular";
        "location-mode" = "path-bar";
        "show-hidden" = true;
        "show-size-column" = true;
        "show-type-column" = true;
        "sort-column" = "name";
        "sort-directories-first" = true;
        "sort-order" = "ascending";
        "type-format" = "category";
        "view-type" = "list";
      };

      "org/gnome/desktop/background" = {
        "color-shading-type" = "solid";
        "picture-options" = "zoom";
        "picture-uri" = "file://${wallpaper}";
        "picture-uri-dark" = "file://${wallpaper}";
        "primary-color" = "#000000000000";
        "secondary-color" = "#000000000000";
      };

      "org/gnome/desktop/input-sources" = {
        "current" = mkUint32 0;
        "mru-sources" = [(mkTuple ["xkb" "pl"]) (mkTuple ["xkb" "ru"])];
        "show-all-sources" = false;
        "sources" = [(mkTuple ["xkb" "pl"]) (mkTuple ["xkb" "ru"])];
        "xkb-options" = ["terminate:ctrl_alt_bksp"];
      };

      "org/gnome/desktop/peripherals/keyboard" = {
        "delay" = mkUint32 250;
        "repeat-interval" = mkUint32 20;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        "speed" = 0.0;
        "accel-profile" = "flat";
	"natural-scroll" = "true";
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        "speed" = 0.4;
        "tap-to-click" = true;
        "two-finger-scrolling-enabled" = true;
	"natural-scroll" = true;
      };

      "org/gnome/desktop/privacy" = {
        "old-files-age" = mkUint32 30;
        "recent-files-max-age" = -1;
      };

      "org/gnome/desktop/session" = {
        "idle-delay" = mkUint32 0;
      };

      "org/gnome/desktop/wm/keybindings" = {
        "close" = ["<Super>q"];
        "minimize" = ["<Super>n"];
        "move-to-workspace-1" = ["<Super><Shift>1"];
        "move-to-workspace-10" = ["<Super><Shift>0"];
        "move-to-workspace-2" = ["<Super><Shift>2"];
        "move-to-workspace-3" = ["<Super><Shift>3"];
        "move-to-workspace-4" = ["<Super><Shift>4"];
        "move-to-workspace-5" = ["<Super><Shift>5"];
        "move-to-workspace-6" = ["<Super><Shift>6"];
        "move-to-workspace-7" = ["<Super><Shift>7"];
        "move-to-workspace-8" = ["<Super><Shift>8"];
        "move-to-workspace-9" = ["<Super><Shift>9"];
        "switch-applications" = ["<Super>Esc"];
        "switch-to-workspace-1" = ["<Super>1"];
        "switch-to-workspace-2" = ["<Super>2"];
        "switch-to-workspace-3" = ["<Super>3"];
        "switch-to-workspace-4" = ["<Super>4"];
        "switch-to-workspace-5" = ["<Super>5"];
        "switch-to-workspace-6" = ["<Super>6"];
        "switch-to-workspace-7" = ["<Super>7"];
        "switch-to-workspace-8" = ["<Super>8"];
        "switch-to-workspace-9" = ["<Super>9"];
        "toggle-maximized" = ["<Super>m"];
	    "switch-to-workspace-left" = ["<Control><Super>h"];
	    "switch-to-workspace-right" = ["<Control><Super>l"];

    # Move windows to other workspaces vertically
    "move-to-workspace-left" = ["<Super><Shift>h"];
    "move-to-workspace-right" = ["<Super><Shift>l"];
      };

      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = lib.mkForce "";
        "focus-mode" = "sloppy";
        "num-workspaces" = 5;
        "titlebar-font" = "Roboto Bold 11";
        "workspace-names" = ["1"];
      };

      "org/gnome/mutter" = {
        "center-new-windows" = true;
        "dynamic-workspaces" = true;
  "workspaces-only-on-primary" = false;
  "disable-animations" = false;  # Ensure this is set to false
        "edge-tiling" = false;
	"overlay-key" = "";
      };


      

      "org/gnome/nautilus/preferences" = {
        "default-folder-viewer" = "list-view";
        "migrated-gtk-settings" = true;
        "search-filter-time-type" = "last_modified";
        "search-view" = "list-view";
      };

      "org/gnome/settings-daemon/plugins/color" = {
        "night-light-enabled" = true;
        "night-light-last-coordinates" = mkTuple [44.437359000257999 26.090661799999999];
        "night-light-temperature" = mkUint32 3700;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        "custom-keybindings" = [

          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/"
        ];
      };
	"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10" = {
	  "binding" = "<Super>Tab";
	  "command" = "ulauncher";
	  "name" = "Ulauncher";
	};

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        "binding" = "<Super>v";
        "command" = "neovide";
        "name" = "Neovide";
      };


      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        "binding" = "<Super>s";
        "command" = "pop-shell-stack";
        "name" = "Stack windos";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        "binding" = "<Super>t";
        "command" = "kitty";
        "name" = "Terminal";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
        "binding" = "<Super>b";
        "command" = "brave";
        "name" = "Brave";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
        "binding" = "<Super>f";
        "command" = "nautilus";
        "name" = "Files";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" = {
        "binding" = "<Shift><Super>t";
        "command" = "telegram-desktop";
        "name" = "Telegram";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" = {
        "binding" = "<Alt><Ctrl>p";
        "command" = "gnome-pomodoro --start-stop";
        "name" = "Pomodoro";
      };


"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9" = {
  "binding" = "<Super>y";
  "command" = "pop-shell-toggle";
  "name" = "Toggle Window Tiling";
};

      "org/gnome/settings-daemon/plugins/power" = {
        "sleep-inactive-ac-type" = "nothing";
        "sleep-inactive-battery-type" = "nothing";
      };

      "org/gnome/shell" = {
        "disable-user-extensions" = false;
        "enabled-extensions" = [
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "blur-my-shell@aunetx"
          "clipboard-history@alexsaveau.dev"
          "dash-to-dock@micxgx.gmail.com"
          "just-perfection-desktop@just-perfection"
          "pomodoro@arun.codito.in"
          "pop-shell@system76.com"
          "rounded-window-corners@fxgn"
          "space-bar@luchrioh"
          "unblank@sun.wxg@gmail.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
        "favorite-apps" = [
          "org.gnome.Nautilus.desktop"
          "brave-browser.desktop"
          "kitty"
          "org.telegram.desktop.desktop"
          "spotify.desktop"
        ];
      };

      "org/gnome/shell/extensions/auto-move-windows" = {
        "application-list" = [
          "brave-browser.desktop:1"
          "Alacritty.desktop:2"
          "org.telegram.desktop.desktop:3"
          "spotify.desktop:4"
          "com.obsproject.Studio.desktop:4"
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        "settings-version" = 2;
      };

      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        "pipeline" = "pipeline_default_rounded";
      };

      "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
        "pipeline" = "pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        "pipeline" = "pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        "pipeline" = "pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
        "pipeline" = "pipeline_default";
      };

      "org/gnome/shell/extensions/clipboard-history" = {
        "display-mode" = 3;
        "next-entry" = ["<Shift><Alt>j"];
        "prev-entry" = ["<Shift><Alt>k"];
        "toggle-menu" = ["<Shift><Alt>v"];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        "animate-show-apps" = true;
        "apply-custom-theme" = false;
        "autohide" = true;
        "background-color" = "rgb(24,25,38)";
        "background-opacity" = 0.8;
        "custom-background-color" = true;
        "custom-theme-shrink" = true;
        "dash-max-icon-size" = 32;
        "dock-fixed" = false;
        "dock-position" = "BOTTOM";
        "extend-height" = false;
        "height-fraction" = 0.9;
        "hot-keys" = false;
        "intellihide" = false;
        "intellihide-mode" = "FOCUS_APPLICATION_WINDOWS";
        "preferred-monitor" = -2;
        "preferred-monitor-by-connector" = "DisplayPort-0";
        "preview-size-scale" = 0.0;
        "show-show-apps-button" = false;
        "show-trash" = false;
        "transparency-mode" = "DYNAMIC";
      };

      "org/gnome/shell/extensions/pop-shell" = {
        "active-hint" = false;
        "gap-inner" = mkUint32 1;
        "gap-outer" = mkUint32 1;
        "tile-by-default" = true;
      };



      "org/gnome/shell/extensions/just-perfection" = {
        "accessibility-menu" = true;
        "activities-button" = true;
        "activities-button-icon-monochrome" = false;
        "activities-button-label" = true;
        "app-menu" = false;
        "app-menu-icon" = true;
        "app-menu-label" = true;
        "background-menu" = true;
        "clock-menu" = true;
        "controls-manager-spacing-size" = 0;
        "dash" = true;
        "dash-icon-size" = 0;
        "dash-separator" = true;
        "double-super-to-appgrid" = true;
        "gesture" = true;
        "hot-corner" = false;
        "notification-banner-position" = 2;
        "osd" = false;
        "panel" = true;
        "panel-arrow" = true;
        "panel-button-padding-size" = 4;
        "panel-corner-size" = 0;
        "panel-in-overview" = true;
        "panel-indicator-padding-size" = 0;
        "panel-notification-icon" = true;
        "panel-size" = 0;
        "power-icon" = true;
        "quick-settings" = true;
        "ripple-box" = true;
        "screen-sharing-indicator" = true;
        "search" = true;
        "show-apps-button" = true;
        "startup-status" = 0;
        "theme" = false;
        "window-demands-attention-focus" = false;
        "window-menu-take-screenshot-button" = true;
        "window-picker-icon" = true;
        "window-preview-caption" = true;
        "window-preview-close-button" = true;
        "workspace" = false;
        "workspace-background-corner-size" = 0;
        "workspace-peek" = false;
        "workspace-popup" = true;
        "workspace-switcher-size" = 0;
        "workspace-wrap-around" = false;
        "workspaces-in-app-grid" = true;
      };

      "org/gnome/shell/extensions/rounded-window-corners" = {
        "border-color" = mkTuple [0.71764707565307617 0.74117660522460938 0.97254902124404907 1.0];
        "border-width" = 1;
        global-rounded-corner-settings = [
          (mkDictionaryEntry [
            "padding"
            (mkVariant [
              (mkDictionaryEntry ["top" (mkVariant 1)])
              (mkDictionaryEntry ["left" (mkVariant 1)])
              (mkDictionaryEntry ["right" (mkVariant 1)])
              (mkDictionaryEntry ["bottom" (mkVariant 1)])
            ])
          ])

          (mkDictionaryEntry [
            "keep_rounded_corners"
            (mkVariant [
              (mkDictionaryEntry ["maximized" (mkVariant true)])
              (mkDictionaryEntry ["fullscreen" (mkVariant false)])
            ])
          ])

          (mkDictionaryEntry ["border_radius" (mkVariant 8)])
          (mkDictionaryEntry ["smoothing" (mkVariant 0)])
          (mkDictionaryEntry ["enabled" (mkVariant true)])
        ];
        "skip-libadwaita-app" = false;
        "skip-libhandy-app" = false;
      };

      "org/gnome/shell/extensions/space-bar/appearance" = {
        "inactive-workspace-text-color" = "rgb(154,153,150)";
        "workspace-margin" = 3;
        "workspaces-bar-padding" = 3;
      };

      "org/gnome/shell/extensions/space-bar/behavior" = {
        "scroll-wheel" = "panel";
        "show-empty-workspaces" = false;
        "smart-workspace-names" = false;
        "toggle-overview" = false;
      };

      "org/gnome/shell/extensions/space-bar/shortcuts" = {
        "enable-activate-workspace-shortcuts" = true;
        "enable-move-to-workspace-shortcuts" = true;
      };

"org/gnome/shell/keybindings" = {
  "toggle-overview" = ["<Super>d"]; # Super + D for Activities Overview
};
      "org/gnome/shell/keybindings" = {
        "show-screen-recording-ui" = ["<Shift><Super>r"];
        "show-screenshot-ui" = ["<Shift><Super>S"];
        "switch-to-application-1" = [];
        "switch-to-application-2" = [];
        "switch-to-application-3" = [];
        "switch-to-application-4" = []; "switch-to-application-5" = [];
        "switch-to-application-6" = [];
        "switch-to-application-7" = [];
        "switch-to-application-8" = [];
        "switch-to-application-9" = [];
        "toggle-application-view" = ["<Super>a"];
        "toggle-message-tray" = ["<Super>c"];
      };

    };
  }
