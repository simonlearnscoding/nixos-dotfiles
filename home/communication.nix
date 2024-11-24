{pkgs, ...}: {
  home.packages = with pkgs; [
    telegram-desktop
    slack
    whatsapp-for-linux
    # webcord
    vesktop
  ];
}
