{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;

  users.groups.uinput.members = ["simon"];
  users.groups.input.members = ["simon"];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth.enable = true;
  };
}
