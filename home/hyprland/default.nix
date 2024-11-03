{inputs, ...}: {
  imports = [
    ./hyprland.nix
    ./config/default.nix
    ./hyprlock.nix
    ./variables.nix
    # inputs.hyprland.homeManagerModules.default
  ];
}
