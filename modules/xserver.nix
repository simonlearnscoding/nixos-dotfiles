{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["amdgpu"];
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
