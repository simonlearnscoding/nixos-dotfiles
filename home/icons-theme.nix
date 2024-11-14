# users/ana/home.nix
{pkgs, ...}: {
  # ...

  # home.packages = with pkgs; [
  #   cinnamon.nemo
  # ];
  gtk = {
    enable = true;

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };

    # cursorTheme = {
    #   name = "Numix-Cursor";
    #   package = pkgs.numix-cursor-theme;
    # };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # home.sessionVariables.GTK_THEME = "Tokyonight-Dark-B";
  home.sessionVariables.GTK_THEME = "rose-pine";
  # ...
}
