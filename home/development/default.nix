{
  pkgs,
  inputs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    yarn
    pass-git-helper
    xh
    progress
    noti
    topgrade
    gitkraken
    tealdeer
    nixd
    monolith
    (pkgs-unstable.mongodb-compass)
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
    cava
    figlet
    python3
    nodejs_20
    gcc
    gnumake
    gh
    git
    github-copilot-cli
    neovide
    lazygit
    zsh
    oh-my-zsh
    sqlite
    (import ./vscode-js-debug.nix {inherit pkgs;})
  ];

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
      #typescript-language-server  # TypeScript and JavaScript LSP
      nodePackages.prettier # JavaScript/TypeScript formatter
      tailwindcss-language-server

      # For Lua
      lua-language-server # Lua LSP
      stylua # Lua code formatter
      #     emmet_ls
      texlab

      # For Nix
      nixpkgs-fmt # Nix formatter
      alejandra
      # nil
      nixd
    ];
  };
}
