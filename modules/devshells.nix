{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      poetry
      nodejs_20
    ]
    ++ (lib.mapAttrsToList (name: value: (pkgs.writeShellScriptBin name value)) {
      python = "steam-run poetry run -C . python $@";
      python3 = "steam-run poetry run -C . python $@";
      pyinit = "poetry init -C .";
      pi = "steam-run poetry -C . add $@";
      pu = "steam-run poetry -C . remove $@";
      py = "steam-run poetry -C ~/.config/python/ run bpython $@";
      pyetry = "steam-run poetry -C ~/.config/python/ $@";

      yarn = "corepack yarn $@";
      yarnpkg = "corepack yarnpkg $@";
      pnpm = "corepack pnpm $@";
      pnpx = "corepack pnpx $@";
      npm = "corepack npm $@";
      npx = "corepack npx $@";

      nix-ld-run = ''
        LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NIX_LD_LIBRARY_PATH" LD="$NIX_LD" $@
      '';
    });
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];
  # Put libraries here that you need to use for python libraries
}
