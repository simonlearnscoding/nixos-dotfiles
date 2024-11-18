{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    sops
  ];

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ./../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  # Use config.home.homeDirectory for the key file path
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  # Declare secrets for Home Manager
  sops.secrets."db-password" = {};

  # Example: Export a secret as an environment variable
  environment.variables = {
    DB_PASSWORD = builtins.readFile "/run/secrets/db-password";
  };

  # Example: Add a HOW TO USE section if needed
  # let
  #   secretConfig = builtins.fromJSON (builtins.readFile "/run/secrets/root-secret");
  # in
  # {
  #   services.postgresql.authentication.password = secretConfig."db-password";
  #   environment.variables.API_KEY = secretConfig."api-key";
  #   environment.variables.NEW_SECRET = secretConfig."new-secret";
  # }
}
