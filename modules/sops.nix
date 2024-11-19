{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops.defaultSopsFile = ./../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  # Use a fixed path for the key file
  sops.age.keyFile = "/home/simon/.config/sops/age/keys.txt";

  # Declare secrets for NixOS
  sops.secrets."db-password" = {
    owner = "simon"; # Specify the user
    group = "users"; # Specify the group (optional)
    mode = "0600"; # Restrict access to the owner only
  };

  # Export the secret as an environment variable for system-level use
  environment.variables = {
    DB_PASSWORD = "/run/secrets/db-password";
  };
}
