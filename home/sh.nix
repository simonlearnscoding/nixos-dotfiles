{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: let
  myAliases = {
    nom = "nix";
    mkdir = "mkdir -p";
    l = "eza --icons";
    ls = "eza --icons";
    fl = "y";
    lf = "y";
    open = "xdg-open";
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
    tt = "taskwarrior-tui";
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

  programs.ssh.extraConfig = ''
    ServerAliveInterval 30
    ServerAliveCountMax 3
  '';
  # programs.stylix.targets.kitty.enable = true;
  programs.kitty = {
    enable = true;
    package = pkgs-unstable.kitty;
    theme = "Rosé Pine";
    settings = {
      enable_audio_bell = false;
      font_family = "JetBrainsMono Nerd Font";
      # background_opacity = "0.9";
      background_blur = "12";
      cursor_trail = "3";
      cursor_trail_start_threshold = "2";
      cursor_trail_decay = "0.1 0.4";
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

  programs.zsh.initExtra = ''
        source ~/.p10k.zsh
        krabby random


    function fzf() {
      local selected_file
      selected_file=$(command fzf) || return
      xdg-open "$selected_file"
    }
      function y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      	yazi "$@" --cwd-file="$tmp"
      	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		builtin cd -- "$cwd"
      	fi
      	rm -f -- "$tmp"
      }
  '';
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
    pkgs-unstable.kitty
    bat
    trash-cli
    yazi
    zoxide
  ];
}
