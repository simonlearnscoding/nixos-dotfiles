{pkgs, ...}:
{  gtk = {
  enable = true;
  theme = {
	name = "rose-pine";
	package = pkgs.rose-pine-gtk-theme;
	  };
  iconTheme = {
	package = pkgs.whitesur-icon-theme;
	name = "whitesur";
	  };
	gtk3.extraConfig = {
	      Settings = ''
		gtk-application-prefer-dark-theme=1
	      '';
	    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  }
