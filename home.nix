{ pkgs, lib, inputs, ... }: let
  username = "simon";
  homeDirectory = "/home/${username}";
in
{
  imports = [
    ./sh.nix
    ./music-production.nix
#   inputs.xremap-flake.homeManagerModules.default
  ];

  nixpkgs.config = { allowUnfree = true; };

  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "24.05";

    packages = with pkgs; [
      fzf
      glib
      yarn
      grim
      slurp
#     network-manager-applet
      blueman
      gifsicle
      gitkraken
      python3
      ffmpeg
      nodejs_20
      jq
      chromium
      libsecret
      brightnessctl
      wf-recorder
      gnome.gnome-keyring
      opera
      brave
      btop
      neovim
      nh
      pamixer
      nix-output-monitor
      gnumake
      lf
      gh
      git
      github-copilot-cli
      telegram-desktop
      pokemon-colorscripts-mac
      xdg-utils
      neofetch
      lazygit
      bat
      zsh
      oh-my-zsh
      eza
      zoxide
      taskwarrior3
      taskwarrior-tui
      syncthing
      gnome.nautilus
      webcord
      sops
      gcc
      neovide
      slack
    # polkit_kde_agent
      trash-cli
      kitty-img
    ];
  };

# HYPRLAND 


#wayland.windowManager.hyprland = {
#enable = true;
#settings = {
#"plugin:borders-plus-plus" = {
#   add_borders = 1;
#   "col.border_1" = "rgb(fffff)";
#   "col.border_2" = "rgb(2222ff)";
#   border_size_1 = 10;
#   border_size_2 = -1;
#   natural_rounding = "yes";
# };
# };
# };

# services = {
#   dbus.enable = true;
#   networkmanager = {
#     enable = true;
#     applet.enable = true;
#   };
#   bluez = {
#     enable = true;
#   };
#   polkit = {
#     enable = true;
#     extraConfig = ''
#       [Configuration]
#       AdminIdentities=unix-group:sudo
#     '';
#   };
# };
#
# systemd.user.services = {
#   polkit-agent = {
#     description = "Polkit KDE Authentication Agent";
#     after = [ "graphical-session.target" ];
#     wantedBy = [ "default.target" ];
#     serviceConfig = {
#       ExecStart = "${pkgs.polkit_kde_agent}/libexec/polkit-kde-authentication-agent-1";
#       Restart = "always";
#     };
#   };
# };
}
