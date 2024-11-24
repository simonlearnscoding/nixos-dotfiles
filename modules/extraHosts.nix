{ config, lib, pkgs, ... }:

let
  # Attempt to import the default blocked hosts file. Fallback to an empty list if not found.
  defaultBlockedHosts = builtins.tryEval (
    import ./default-blocked-hosts.nix
  ).value or [];
in
{
  options.blockedHosts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    description = "List of domains to block by redirecting to localhost.";
    default = defaultBlockedHosts;
  };

  # Generate extraHosts based on blockedHosts
  config.networking.extraHosts = lib.concatMapStrings (host: ''
    127.0.0.1 ${host}
  '') config.blockedHosts;
}
