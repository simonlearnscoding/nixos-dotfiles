{...}: {
  home.sessionVariables = {
    # Wayland core variables
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland"; # Changed from xcb to wayland
    QT_QPA_PLATFORMTHEME = "qt5ct"; # Better for Wayland
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # Browser and Electron
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Force Electron to Wayland

    # Graphics and rendering
    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # Gaming and OpenGL
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";

    # Application-specific
    ANKI_WAYLAND = "1";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    DISABLE_QT5_COMPAT = "0";

    # Utilities
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    DIRENV_LOG_FORMAT = "";

    # Optional: Force specific toolkits to Wayland
    # GTK_USE_PORTAL = "1";
    # BEMENU_BACKEND = "wayland";
    # WLR_DRM_NO_ATOMIC = "1";  # Consider removing if not needed
  };
}
