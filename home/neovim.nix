{ pkgs, config, lib, ... }: let
  neovim_config = ./../files/configs/nvim;
in {
  # Neovim text editor configuration
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraPackages = with pkgs; [
      black
      ripgrep
      gcc
      gnumake
      nodejs_22
      python3
      isort
      lua-language-server
      markdownlint-cli
      nixd
      nodePackages.bash-language-server
      nodePackages.prettier
      pyright
      ruff
      shellcheck
      shfmt
      stylua
      terraform-ls
      tflint
      vscode-langservers-extracted
      yaml-language-server
    ];
  };


  # Symlink for Neovim configuration
# home.file.".config/nvim" = {
#   source = neovim_config; # Directly use the neovim_config variable
#   recursive = true;
# };
}
