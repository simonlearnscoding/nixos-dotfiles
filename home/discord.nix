{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "vesktop" ''
      #!${pkgs.bash}/bin/bash
      exec discord "$@"
    '')
  ];
}
