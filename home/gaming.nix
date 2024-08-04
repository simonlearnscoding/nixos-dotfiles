{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    mangohud
    protonup
  ];

# GAMING
  programs.gamemode.enable = true;
  programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/simon/.steam/root/compatibilitytools.d"; 
    };
}
