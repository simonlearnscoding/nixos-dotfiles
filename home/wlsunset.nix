{
  pkgs,
  config,
  lib,
  ...
}: {
  services.wlsunset = {
    enable = true;
    # Switzerland's latitude and longitude
    latitude = 46.8182;
    longitude = 8.2275;
    temperature.day = 6500;
    temperature.night = 3700;
  };
}
