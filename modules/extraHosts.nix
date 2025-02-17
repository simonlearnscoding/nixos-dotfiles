{
  config,
  pkgs,
  lib,
  ...
}: let
  # Path to the hosts file
  hostsFile = ./blocked-hosts.txt;

  # Read the contents of the hosts file
  hostsContents = lib.strings.fileContents hostsFile;

  # Function to clean up the hosts file
  cleanHosts = lib.strings.concatMapStringsSep "\n" (
    line: let
      cleanedLine = lib.strings.removeSuffix "\n" (lib.strings.removeSuffix "\r" line);
    in
      if lib.strings.hasPrefix "#" cleanedLine || cleanedLine == ""
      then ""
      else cleanedLine
  ) (lib.strings.splitString "\n" hostsContents);

  # Encrypted password (replace with your encrypted string)
  encryptedPassword = "U2FsdGVkX1+Ix8JxGh7jzbipzrnTyvVs+kqD3QE1nUM=";

  # Script to unlock the file
  unlockScript = pkgs.writeShellScriptBin "unlock-hosts" ''
    echo "Enter the password to unlock ${hostsFile}:"
    read -s password

    # Decrypt the stored password
    stored_password=$(echo "${encryptedPassword}" | ${pkgs.openssl}/bin/openssl enc -d -aes-256-cbc -a -k "encryption_key")

    if [ "$password" == "$stored_password" ]; then
      ${pkgs.toybox}/bin/toybox chattr -i ${hostsFile}
      echo "File unlocked."
    else
      echo "Incorrect password."
    fi
  '';
in {
  # Add the cleaned hosts to networking.extraHosts
  networking.extraHosts = cleanHosts;

  # Make the hosts file immutable on system activation
  system.activationScripts.makeHostsImmutable = lib.mkAfter ''
    echo "Setting immutable flag on ${hostsFile}..."
    ${pkgs.toybox}/bin/toybox chattr +i ${hostsFile}
    echo "Immutable flag set."
  '';

  # Restrict sudo access to the file
  security.sudo.configFile = ''
    # Prevent root from modifying the blocked-hosts.txt file
    root ALL=(ALL) !/bin/chmod, !/bin/chown, !/bin/rm, !/bin/mv, !/bin/cp, !/bin/chattr ${hostsFile}
    root ALL=(ALL) !${pkgs.toybox}/bin/toybox chattr ${hostsFile}
  '';

  # Add the unlock script and toybox to the system environment
  environment.systemPackages = [pkgs.openssl unlockScript pkgs.toybox];
}
