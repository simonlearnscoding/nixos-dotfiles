{
  config,
  lib,
  pkgs,
  ...
}: let
  # Check if the file exists, and if not, use an empty list as a fallback
  defaultBlockedHosts =
    if builtins.pathExists ./default-blocked-hosts.nix
    then import ./default-blocked-hosts.nix
    else [
    ];
in {
  options.blockedHosts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    description = "List of domains to block by redirecting to localhost.";
    default = defaultBlockedHosts;
  };

  # Generate extraHosts based on blockedHosts
  config.networking.extraHosts =
    lib.concatMapStrings (host: ''
      127.0.0.1 ${host}
    '')
    config.blockedHosts;
}
