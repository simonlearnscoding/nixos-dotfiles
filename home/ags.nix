{ pkgs, ... }: {
  # Include user-specific packages via Home Manager
  home.packages = with pkgs; [
    ags
  ];

  home.file.".config/ags/" = {
    source = builtins.path { path = ./configfiles/ags; };
    recursive = true;
  };

  # Configure a systemd service to start ags automatically
  systemd.user.services.ags = {
    description = "AGS Service"; # Description for the service
    wantedBy = ["default.target"]; # Start with the user session
    serviceConfig = {
      ExecStart = "${pkgs.ags}/bin/ags"; # Path to the ags executable
      Restart = "always"; # Restart the service if it crashes
      RestartSec = 5; # Delay before restarting
    };
  };
}
