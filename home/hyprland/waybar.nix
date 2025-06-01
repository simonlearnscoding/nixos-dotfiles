{pkgs, ...}: {
  home.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    fantasque-sans-mono

    socat # Required for Hyprland workspace events
    jq # For JSON processing
    playerctl
    waybar
    wlogout
  ];
  home.file.".config/waybar/" = {
    source = builtins.path {path = ./../configfiles/waybar;};
    recursive = true;
  };
}
