{ config, pkgs, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      RUNTIME_PM_ON_AC = "auto";
      WIFI_PWR_ON_AC = "on";
      CPU_MAX_PERF_ON_AC = "nn";
      CPU_MAX_PERF_ON_BAT = "nn";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_BAT = 0;
      DISK_DEVICES = "sda sdb";
      DISK_APM_LEVEL_ON_AC = "254 254";
      DISK_APM_LEVEL_ON_BAT = "128 128";
      USB_AUTOSUSPEND = true;
    };
  };
  services.thermald.enable = true;
}
