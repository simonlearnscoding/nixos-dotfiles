# hosts/common.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../modules/stylix.nix
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

  virtualisation.waydroid.enable = true;
  environment.systemPackages = [
    pkgs.power-profiles-daemon
  ];
  programs.gamemode.enable = true;
  programs.steam.enable = true;
}
