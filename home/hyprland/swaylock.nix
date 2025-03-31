{pkgs, ...}: {
  home.packages = with pkgs; [
    swaylock-effects
  ];

  home.file.".config/swaylock/" = {
    source = builtins.path {path = ./../configfiles/swaylock;};
    recursive = true;
  };
}
