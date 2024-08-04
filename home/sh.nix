{ config, pkgs, ... }:

let
  myAliases = {
    nom = "nix";
    l = "eza --icons";
    ls = "eza --icons";
    c = "z";
    ".." = "cd ..";
    cd = "z";
    ci = "zi";
    gg = "lazygit";
    cadd = "zoxide add";
    cdadd = "zoxide add";
    t = "task";
    td = "task done";
    ta = "task add";
    tm = "task modify";
    tc = "task context";
    rm = "trash-add";
  };
in
{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    font = {
      name = "JetBrainsMono";
      size = 12;
    };
    extraConfig = "padding 8";
    shellIntegration.enableZshIntegration = true;
  };
  
  programs.fzf.enable = true;
  
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      };
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "rust"
        "deno"
      ];
    shellAliases = myAliases;
  };
  
  home.packages = with pkgs; [
    taskwarrior3
    taskwarrior-tui
    fzf
    jq
    eza
    btop
    nix-output-monitor
    nh
    lf
    pokemon-colorscripts-mac
    neofetch
    kitty
    bat
    trash-cli
    zoxide
  ];
}
