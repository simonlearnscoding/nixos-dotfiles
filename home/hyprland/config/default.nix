# hyprland.nix
{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # general = import ./general.nix;
      input = import ./input.nix;
      # misc = import ./misc.nix;
      # dwindle = import ./dwindle.nix;
      # master = import ./master.nix;
      # decoration = import ./decoration.nix;
      # animations = import ./animations.nix;
      bind = import ./keybinds.nix;
      # bindm = import ./mouseBindings.nix;
      # windowrule = import ./windowrules.nix;
      # windowrulev2 = import ./windowrulesv2.nix;
    };

    extraConfig = ''
      monitor=,preferred,auto,auto

      xwayland {
        force_zero_scaling = true;
      }
    '';
  };
}
