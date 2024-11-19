{
  config,
  pkgs,
  ...
}: let
  myAliases = {
    nom = "nix";
    mkdir = "mkdir -p";
    l = "eza --icons";
    ls = "eza --icons";

    ll = "eza -lha --icons=auto --sort=name --group-directories-first";
    c = "z";
    lg = "ls | grep";
    ".." = "cd ..";
    "..." = "cd ../..";
    cd = "z";
    ci = "zi";
    b = "cd ..";
    gg = "lazygit";
    cadd = "zoxide add";
    cdadd = "zoxide add";
    t = "task";
    td = "task done";
    ta = "task add";
    tm = "task modify";
    tc = "task context";
    rm = "trash-put";
    update = "sudo nixos-rebuild switch --flake ~/.nixos/";
  };
in {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # programs.stylix.targets.kitty.enable = true;
  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    settings = {
      enable_audio_bell = false;
      font_family = "JetBrainsMono Nerd Font";
      background_opacity = "0.9";
      background_blur = "12";
      window_padding_width = "8";
      # window_padding_width = 8;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    extraConfig = "padding 8";
    shellIntegration.enableZshIntegration = true;
  };

  programs.fzf.enable = true;

  programs.fish.enable = false;

  programs.zsh.initExtra = "
  source ~/.p10k.zsh
  krabby random 
  ";
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  home.file.".p10k.zsh".source = ./p10k-config/p10k.zsh;
  programs.zsh = {
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
    };
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
    krabby
    taskwarrior3
    taskwarrior-tui
    fzf
    jq
    eza
    btop
    nix-output-monitor
    nh
    wget
    gnumake
    xclip
    lf
    cmake
    gcc
    pokemon-colorscripts-mac
    neofetch
    ripgrep
    kitty
    bat
    trash-cli
    zoxide
  ];
}
