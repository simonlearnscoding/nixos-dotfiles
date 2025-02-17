{
  config,
  lib,
  pkgs,
  ...
}: let
  blockedHostsFile = ./blocked-hosts.txt;

  # Read the file and split it into a list of strings
  blockedHosts =
    if builtins.pathExists blockedHostsFile
    then builtins.filter (line: line != "") (builtins.splitString "\n" (builtins.readFile blockedHostsFile))
    else [];
in {
  options.blockedHosts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    description = "List of domains to block by redirecting to localhost.";
    default = blockedHosts;
  };

  # Generate extraHosts based on blockedHosts
  config.networking.extraHosts =
    lib.concatMapStrings (host: ''
      127.0.0.1 ${host}
    '')
    config.blockedHosts;
}
