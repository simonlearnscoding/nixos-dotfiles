{
  services.swaync = {
    enable = true;
    settings = {
      position = "top-right";
      control-center-position = "right";
      timeout = 6;
      widgets = ["inhibitors" "notification-list" "buttons-grid"];
    };

    style = ''
      /* Catppuccin Mocha palette */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;
      @define-color text   #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;
      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;
      @define-color blue   #89b4fa;
      @define-color lavender #b4befe;
      @define-color sapphire #74c7ec;
      @define-color sky    #89dceb;
      @define-color teal   #94e2d5;
      @define-color green  #a6e3a1;
      @define-color yellow #f9e2af;
      @define-color peach  #fab387;
      @define-color maroon #eba0ac;
      @define-color red    #f38ba8;
      @define-color mauve  #cba6f7;
      @define-color pink   #f5c2e7;
      @define-color flamingo #f2cdcd;
      @define-color rosewater #f5e0dc;

      .notification, .widget {
        background-color: @base;
        border-radius: 12px;
        border: 1px solid @surface0;
        color: @text;
        padding: 12px;
        margin-top: 4px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.4);
      }

      .notification.critical {
        border: 1px solid @red;
        background-color: mix(@red, @base, 0.1);
      }

      .notification.low {
        opacity: 0.85;
      }

      .widget {
        background-color: @mantle;
      }

      .control-center {
        background-color: @crust;
        border-radius: 16px;
        padding: 12px;
      }

      .notification .close-button {
        margin: 20px;

      }
      .button {
        background-color: @surface0;
        color: @text;
        border-radius: 10px;
        padding: 6px 10px;
        margin: 12px;
      }

      .button:hover {
        background-color: @mauve;
        color: @base;
      }
    '';
  };
}
