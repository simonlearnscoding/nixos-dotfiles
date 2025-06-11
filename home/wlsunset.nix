{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wlsunset
    hyprsunset # seems like wlsunset is not doing its job on the pc?
  ];
  services.wlsunset = {
    enable = true;
    # Switzerland's latitude and longitude
    latitude = 46.8182;
    longitude = 8.2275;
    temperature.day = 6500;
    temperature.night = 3400;
  };
}
# {
#   config,
#   lib,
#   pkgs,
#   ...
# }: {
#   services.gammastep = {
#     enable = true;
#     provider = "manual";
#     latitude = 49.0;
#     longitude = 8.4;
#     temperature.night = 3500;
#   };
# }

