# hosts/common.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../modules/stylix.nix
    ./../modules/waydroid.nix
    ./../modules/printing.nix
    ./../modules/extraHosts.nix
    ./../modules/audio.nix
    ./../modules/flatpak.nix
    ./../modules/bluetooth.nix
    ./../modules/wayland.nix
    ./../modules/hyprlandWM.nix
    # ./../modules/gnome.nix
    ./../modules/energy-management.nix
    ./../modules/light.nix
  ];

  boot.plymouth = {
    enable = true;
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    themePackages = [pkgs.catppuccin-plymouth];
    # theme = "catppuccin-macchiato";
  };

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "${config.system.path}/share"
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  virtualisation.waydroid.enable = true;
  virtualisation.libvirtd.enable = true;
  users.users.simon.extraGroups = ["libvirtd" "kvm"];
  programs.virt-manager.enable = true;
  environment.systemPackages = [
    pkgs.power-profiles-daemon
    pkgs.android-studio
  ];
  programs.gamemode.enable = true;
  programs.steam.enable = true;
}
