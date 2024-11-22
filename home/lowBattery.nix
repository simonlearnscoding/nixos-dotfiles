{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    batsignal
  ];
}
