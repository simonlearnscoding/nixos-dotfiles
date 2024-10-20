{
  userConfig,
  pkgs,
  ...
}: {
  # GTK theme configuration
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      gnomeShellTheme = true;
    };
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
    cursorTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
    };
    font = {
      name = "Roboto";
      size = 11;
    };
  };
}
