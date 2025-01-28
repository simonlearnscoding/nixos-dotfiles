{ pkgs, lib, config, pkgs-unstable, ... }: {
  # Common development tools for both desktop and server
  home.packages = with pkgs; [
    yarn
    pass-git-helper
    xh
    progress
    topgrade
    tealdeer
    nixd
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
    figlet
    python3
    nodejs_20
    gcc
    gnumake
    gh
    git
    github-copilot-cli
    lazygit
    zsh
    oh-my-zsh
    sqlite
  ]
  ++ lib.mkIf config.isDesktop (with pkgs; [
    # Desktop-specific development tools
    noti
    gitkraken
    monolith
    (pkgs-unstable.mongodb-compass) # MongoDB GUI
    cava
    neovide
  ]);

  programs.neovim = {
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    extraPackages = with pkgs-unstable; [
      sqlite
      ripgrep
      gcc
      gnumake
      nodejs_20
      python3

      # For Python
      pyright # Python LSP
      black # Python code formatter
      isort # Python import sorter
      ruff # Python linter

      # For JavaScript/TypeScript
      nodePackages.typescript-language-server # TypeScript and JavaScript LSP
      nodePackages.prettier # JavaScript/TypeScript formatter
      tailwindcss-language-server

      # For Lua
      lua-language-server # Lua LSP
      stylua # Lua code formatter
      texlab

      # For Nix
      nixpkgs-fmt # Nix formatter
      alejandra
      nixd
    ];
  };
}
