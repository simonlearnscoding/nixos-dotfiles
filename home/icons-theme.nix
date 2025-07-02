{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    glib
    gnome-settings-daemon
    gtk3
    gtk4
    gnome-themes-extra
    whitesur-gtk-theme
    whitesur-icon-theme
    rose-pine-cursor # Add this package
  ];

  gtk = {
    enable = true;

    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    # Changed to Rose Pine cursor
    cursorTheme = {
      name = "rose-pine-cursor";
      package = pkgs.rose-pine-cursor;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "WhiteSur-Dark";
      gtk-icon-theme-name = "WhiteSur";
      gtk-cursor-theme-name = "rose-pine-cursor"; # Updated
      gtk-cursor-theme-size = 24;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "WhiteSur-Dark";
      gtk-icon-theme-name = "WhiteSur";
      gtk-cursor-theme-name = "rose-pine-cursor"; # Updated
      gtk-cursor-theme-size = 24;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "WhiteSur-Dark";
      icon-theme = "WhiteSur";
      cursor-theme = "rose-pine-cursor"; # Updated
      cursor-size = 24;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "WhiteSur-Dark";
    XCURSOR_THEME = lib.mkForce "rose-pine-cursor"; # Force override
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_STYLE_OVERRIDE = "gtk2";
    QT_QPA_PLATFORMTHEME = "gtk2";
  };

  services.gnome-keyring.enable = true;
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
}
