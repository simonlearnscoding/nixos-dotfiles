{ config, pkgs, ... }:

{
  services.xremap = {
    withWlroots = true;
    userName = "simon";
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
