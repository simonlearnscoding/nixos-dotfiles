{ config, pkgs, ... }:

{
  services.xremap = {
    enabled = false;
#   withWlroots = true;
#   userName = "simon";
#   config = {
#     modmap = [
#       {
#         name = "Global";
#         remap = {
#           "CapsLock" = "Esc"; # globally remap CapsLock to Esc
#         };
#       }
#     ];
#   };
  };
}
