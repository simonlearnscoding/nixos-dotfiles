{config, pkgs, lib }:

{

environment.systemPackages = (lib.mapAttrsToList (name: value: (pkgs.writeShellScriptBin name value)) {
    python = "nix-ld-run poetry run -C ~/.config/python/ python $@";
    python3 = "nix-ld-run poetry run -C ~/.config/python/ python $@";
    pyinit = "mkdir -p ~/.config/python/ && poetry init -C ~/.config/python/";
    pi = "nix-ld-run poetry -C ~/.config/python/ add $@";
    pu = "nix-ld-run poetry -C ~/.config/python/ remove $@";
    py = "nix-ld-run poetry -C ~/.config/python/ run bpython $@";
    pyetry = "nix-ld-run poetry -C ~/.config/python/ $@";

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
