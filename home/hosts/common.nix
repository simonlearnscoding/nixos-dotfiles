{ pkgs, lib, ... }: 

let
  username = "simon";
  homeDirectory = "/home/${username}";

  # Package sets
  commonPackages = with pkgs; [
    ffmpeg
    syncthing
    unzip
    devenv
    direnv
    libsecret
    deluge
  ];

  desktopPackages = with pkgs; [
    gnutls
    cdrtools
    libnotify
    mongodb
    mongodb-tools
  ];

  serverPackages = with pkgs; [
    openssh
  ];

  # Import lists
  commonImports = [
    ./../user.nix
    ./../info-fetchers.nix
    ./../taskwarrior.nix
    ./../development/default.nix
    ./../sh.nix
  ];

  desktopImports = [
    ./../ags.nix
    ./../hyprpanel.nix
    ./../obs-studio.nix
    ./../spotify.nix
    ./../icons-theme.nix
    ./../wlsunset.nix
    ./../wofi.nix
    ./../development/server.nix
    ./../browser.nix
    ./../hyprland/default.nix
    ./../communication.nix
    ./../media-tools.nix
    ./../system-utilities.nix
  ];

in {
  options.isDesktop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Whether this configuration is for a desktop.
      Changes package selection and service configuration.
    '';
  };

  config = {
    nixpkgs.config.allowUnfree = true;

    home = {
      username = username;
      homeDirectory = homeDirectory;
      stateVersion = "24.05";

      packages = commonPackages
        ++ lib.mkIf config.isDesktop desktopPackages
        ++ lib.mkIf (!config.isDesktop) serverPackages;
    };

    imports = commonImports
      ++ lib.mkIf config.isDesktop desktopImports;

    # Potential future service configuration (example)
    # services.flatpak.enable = lib.mkIf config.isDesktop true;
  };
}
