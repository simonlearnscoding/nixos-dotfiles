{pkgs, ...}: {
  home.packages = with pkgs; [
    webcord
  ];
  # vesktop
  # (pkgs.writeShellScriptBin "discord" ''
  #   #!${pkgs.bash}/bin/bash
  #   exec vesktop "$@"
  # '')
  # ];

  # home.file.".config/vesktop" = {
  #   source = builtins.path {path = ./configfiles/vesktop;};
  #   recursive = true;
  # };
}
