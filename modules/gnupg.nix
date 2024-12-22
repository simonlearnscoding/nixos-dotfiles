{
  config,
  pkgs,
  ...
}: {
  programs.gnupg.agent = {
    # Enables the GnuPG agent to manage keys and encryption.
    enable = true;
    # Adds support for using GnuPG as an SSH agent, allowing SSH authentication with GPG keys.
    enableSSHSupport = true;
  };
}
