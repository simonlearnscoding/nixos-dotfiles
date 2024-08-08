
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscodium
    yarn
    pass-git-helper
    xh
    zllij
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
    neovim
    neovide
    lazygit
    zsh
    oh-my-zsh
  ];
  xdg.configFile."nvim" = {
    source = ./neovim/nvim;
  };
# home.file.".config/nvim" = {
#     source = ./neovim/nvim;
#     target = "symlink";
#   };
}
