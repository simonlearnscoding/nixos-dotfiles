
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
  xdg.configFile."nvim" = {
    source = ./neovim/nvim;
  };
# home.file.".config/nvim" = {
#     source = ./neovim/nvim;
#     target = "symlink";
#   };
}
