
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yarn
    gitkraken
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
  home.file.".config/nvim" = {
      source = ./neovim/nvim;
      target = "symlink";
    };
}
