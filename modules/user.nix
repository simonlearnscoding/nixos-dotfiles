
{ config, pkgs, ... }:

{
  users.users.simon = {
    isNormalUser = true;
    description = "simon";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Enable automatic login for the user.
  services.getty.autologinUser = "simon";
}
