{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];
  system.stateVersion = "24.05"; # Did you read the comment?
}
