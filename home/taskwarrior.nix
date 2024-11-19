{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    taskwarrior3
    taskwarrior-tui
  ];
  programs.taskwarrior.colorTheme = "solarized-dark-256";
}
