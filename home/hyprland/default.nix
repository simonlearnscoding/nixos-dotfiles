{inputs, ...}: {
  imports = [
    ./hyprland.nix
    ./config/default.nix
    ./hyprlock.nix
    ./swww.nix
    ./variables.nix
    # inputs.hyprland.homeManagerModules.default
  ];
}
