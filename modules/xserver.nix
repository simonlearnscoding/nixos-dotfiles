{
  config,
  pkgs,
  ...
}: {
  # Configure keymap in X11
  services.xserver.videoDrivers = ["amdgpu"];

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Remove decorations for QT applications
  environment.sessionVariables = {
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };
}
