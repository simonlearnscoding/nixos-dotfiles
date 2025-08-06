{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    zoom
    teamviewer
    pkgs-unstable.discord
    teams-for-linux
    telegram-desktop
    pkgs-unstable.slack
    whatsapp-for-linux
  ];
}
