{
  pkgs,
  inputs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    yarn
    deno
    pass-git-helper
    xh
    progress
    noti
    topgrade
    tealdeer
    nixd
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
    cava
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
      # Add debugpy explicitly
      python3Packages.debugpy

      # Language servers and formatters
      pyright
      black
      isort
      ruff
      nodePackages.typescript-language-server
      nodePackages.prettier
      tailwindcss-language-server
      lua-language-server
      stylua
      texlab
      nixpkgs-fmt
      alejandra
      nixd
    ];
  };
}
