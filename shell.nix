{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = [
    pkgs.git
    pkgs.nodejs
    pkgs.python3
  ];

  shellHook = ''
    echo "Welcome to the development shell!"
  '';
}
