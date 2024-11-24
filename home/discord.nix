{pkgs, ...}: {
  home.packages = with pkgs; [
    vesktop
    (pkgs.writeShellScriptBin "discord" ''
      #!${pkgs.bash}/bin/bash
      exec vesktop "$@"
    '')
  ];

  home.file.".config/vesktop" = {
    source = builtins.path {path = ./configfiles/vesktop;};
    recursive = true;
  };
}
