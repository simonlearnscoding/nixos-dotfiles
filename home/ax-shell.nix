# ~/.config/home-manager/modules/ax-shell.nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.ax-shell;

  # Combined Python environment with core + user-added packages
  # Corrected Python environment definition

  pythonEnv = pkgs.python3.withPackages (ps:
    with ps; [
      ijson
      numpy
      pillow
      psutil
      requests
      setproctitle # This was missing in the explicit list
      toml
      watchdog
      # Add other required packages from the error logs
      pygobject3
      dbus-python
      fabric
    ]);
in {
  options.programs.ax-shell = {
    enable = mkEnableOption "Ax-Shell desktop interface";

    package = mkOption {
      type = types.package;
      default = pkgs.fetchFromGitHub {
        owner = "Axenide";
        repo = "Ax-Shell";
        rev = "d59f6c3"; # Update using nix-prefetch-github when updating
        sha256 = "sha256-wwx++Yfjda+uW1Rsb9jpjSc//8xYiugmTyugSKECKx0=";
      };
      description = ''
        Ax-Shell source package. Use nix-prefetch-github to update SHA256
        when changing the revision.
      '';
    };

    blurEnabled = mkOption {
      type = types.bool;
      default = true;
      description = "Enable blur effects for composited elements";
    };

    extraPythonPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional Python packages for Ax-Shell extensions";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Core system utilities
      brightnessctl # Display brightness control
      cairo #
      gtk-layer-shell # Wayland compositor integration
      libappindicator
      libdbusmenu
      hypridle # Hyprland idle daemon
      hyprlock # Screen locker
      hyprpicker # Color picker
      libnotify # Desktop notifications
      playerctl # Media player control
      swww # Wallpaper engine
      tesseract # OCR engine
      uwsm # Wayland session manager
      wl-clipboard # Clipboard utilities
      wlinhibit # Session inhibition
      dart-sass # Required for SCSS compilation
    ];

    # 1. COPY FILES FIRST - Create directory structure and copy source files
    home.activation.ax-shell-copy = lib.hm.dag.entryAfter ["writeBoundary"] ''
      echo "Copying Ax-Shell files to config directory..."
      $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/Ax-Shell"

      # Use rsync to preserve directory structure
      $DRY_RUN_CMD ${pkgs.rsync}/bin/rsync -a --chmod=u+w \
        "${cfg.package}/" \
        "${config.xdg.configHome}/Ax-Shell/"
    '';

    # 2. COMPILE SCSS - Must happen after files are copied
    # home.activation.ax-shell-scss = lib.hm.dag.entryAfter ["ax-shell-copy"] ''
    #   echo "Compiling SCSS assets..."
    #   $DRY_RUN_CMD ${pkgs.dart-sass}/bin/sass \
    #     "${config.xdg.configHome}/Ax-Shell/assets/scss/main.scss" \
    #     "${config.xdg.configHome}/Ax-Shell/assets/css/main.css" \
    #     || {
    #       echo "SCSS compilation failed!"
    #       exit 1
    #     }
    # '';

    # Python environment configuration
    home.sessionVariables = {
      # Ensure Python can find our installed packages
      PYTHONPATH = "${pythonEnv}/${pythonEnv.sitePackages}";
    };

    # Systemd service configuration

    systemd.user.services.ax-shell = {
      Unit = {
        Description = "Ax-Shell Desktop Interface";
        After = ["graphical-session.target"];
        Requires = ["hyprland-session.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = let
          py = "${pythonEnv}/bin/python";
          mainScript = "${config.xdg.configHome}/Ax-Shell/main.py";
        in ''
          ${pkgs.uwsm}/bin/uwsm -- app ${py} ${mainScript}
        '';
        Restart = "on-failure";
        RestartSec = "5s";
        Environment = [
          "PATH=${makeBinPath [pkgs.brightnessctl pkgs.hyprpicker pkgs.glib]}"
          "PYTHONPATH=${pythonEnv}/${pythonEnv.sitePackages}"
          # Fixed XDG_RUNTIME_DIR
          "XDG_RUNTIME_DIR=/run/user/$UID"
        ];
      };

      Install.WantedBy = ["hyprland-session.target"];
    };

    # Hyprland compositor integration
    wayland.windowManager.hyprland.extraConfig = optionalString cfg.blurEnabled ''
      # Required for blur effects in Ax-Shell components
      layerrule = blur, fabric
      layerrule = ignorezero, fabric
    '';

    # Post-install checks
    # home.activation.ax-shell-verify = lib.hm.dag.entryAfter ["ax-shell-scss"] ''
    #   echo "Verifying Ax-Shell installation..."
    #   if [ ! -f "${config.xdg.configHome}/Ax-Shell/main.py" ]; then
    #     echo "Error: Main Ax-Shell script not found!"
    #     exit 1
    #   fi
    # '';
  };
}
