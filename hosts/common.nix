# hosts/common.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  # virtualisation.docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #   };
  # };

  imports = [
    ./../modules/user.nix
    ./../modules/sops.nix
    ./../modules/syncthing.nix
    ./../modules/gc.nix
    ./../modules/swap.nix
    ./../modules/fonts.nix
    ./../modules/environment-variables.nix
    # ./../modules/gnome.nix
    ./../modules/hardware.nix
    ./../modules/bootloader.nix
    ./../modules/networking.nix
    ./../modules/user.nix
    ./../modules/gnupg.nix
    ./../modules/system.nix
    ./../modules/locale.nix
    ./../modules/devshells.nix
  ];

  environment.sessionVariables = {
    FLAKE = "/home/simon/nixos-dotfiles";
  };

  programs.zsh.enable = true;
  hardware = {
    opengl = {
      enable = true; # Enable OpenGL for graphics rendering
      driSupport32Bit = true; # Enable 32-bit DRI support for compatibility with certain applications
    };
  };

  # getting access to the eReader
  services.udev.extraRules = ''
    # Allow access to the eReader (idVendor=1f3a, idProduct=1006) for MTP
    ATTR{idVendor}=="1f3a", ATTR{idProduct}=="1006", MODE="0666"
  '';

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Add distrobox to the system packages so that it is installed and available.
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
