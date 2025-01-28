{pkgs, ...}: {
  home.packages = with pkgs; [
    telegram-desktop
    teams-for-linux
    slack
    whatsapp-for-linux
    webcord
  ];
}
