{
  config,
  pkgs,
  lib,
  ...
}: let
  myPython = pkgs.python3.withPackages (pypkgs:
    with pypkgs; [
      setproctitle
      ijson
      numpy
      pillow
      psutil
      requests
      setproctitle # This was missing in the explicit list
      toml
      watchdog
      # Add other required packages from the error logs
      pygobject3
      dbus-python
      fabric
      # You can add other dependencies here if needed
    ]);
in {
  environment.systemPackages = with pkgs;
    [
      myPython
      nodejs_20
    ]
    ++ (lib.mapAttrsToList (name: value: pkgs.writeShellScriptBin name value) {
      python = "${myPython}/bin/python";
      python3 = "${myPython}/bin/python";
      # If you have additional wrappers for other tools, list them here.
      yarn = "corepack yarn \$@";
      yarnpkg = "corepack yarnpkg \$@";
      pnpm = "corepack pnpm \$@";
      pnpx = "corepack pnpx \$@";
      npm = "corepack npm \$@";
      npx = "corepack npx \$@";
    });

  environment.sessionVariables = {
    # Prepend the custom python's bin to PATH to ensure it's picked up first.
    PATH = "${myPython}/bin:" + lib.getEnv "PATH";
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      pkgs.stdenv.cc.cc
      pkgs.zlib
      pkgs.openssl
    ];
  };
}
