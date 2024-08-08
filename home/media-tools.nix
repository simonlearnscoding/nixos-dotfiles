{ config, pkgs, ... }:

{
  # Existing configurations...

  home.packages = with pkgs; [
    syncthing
    mpv
    xdg-utils
    viewnior  # Adding viewnior as the image viewer
    audacious  # Adding Audacious as the audio player
  ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
      "video/*" = [ "mpv.desktop" ];       # Default video player is MPV
      "audio/*" = [ "audacious.desktop" ]; # Default audio player is Audacious
      "image/*" = [ "viewnior.desktop" ];  # Default image viewer is Viewnior
  };

  programs.mpv.enable = true;
}
