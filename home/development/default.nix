{ pkgs, ... }:
let
  # Define the paths for necessary binaries and libraries
  bins = [ pkgs.sqlite pkgs.ripgrep pkgs.gcc pkgs.gnumake pkgs.nodejs_20 pkgs.python3 ];

  # Wrap Neovim with the correct environment (LD_LIBRARY_PATH)
  customNeovim = pkgs.symlinkJoin {
    name = "custom-neovim";
    paths = [ pkgs.neovim ] ++ bins;
    buildInputs = [ pkgs.makeWrapper ];

    # Ensure that Neovim sees the libsqlite3.so and other necessary tools
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --set LD_LIBRARY_PATH ${pkgs.lib.makeLibraryPath bins};
    '';
  };
in
{
  home.packages = with pkgs; [
    vscodium
    yarn
    pass-git-helper
    xh
    progress
    noti
    topgrade
    gitkraken
    tealdeer
    monolith
    fd
    tokei
    mdcat
    lsd
    lsof
    gping
    viu
    tre-command
    felix-fm
    cmatrix
    pipes-rs
    rsclock
    cava
    figlet
    python3
    nodejs_20
    gcc
    gnumake
    gh
    git
    github-copilot-cli
    # customNeovim  # Use the wrapped version of Neovim
    neovide
    lazygit
    zsh
    oh-my-zsh
    sqlite
  ];

  # Neovim plugin configuration
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.sqlite-lua;
      config = ''
        let g:sqlite_clib_path = '${pkgs.sqlite}/lib/libsqlite3.so'
      '';
    }
  ];

  # Optionally, you can add your Neovim configuration here
  # xdg.configFile."nvim" = {
  #   source = ./neovim/nvim;
  # };
}
