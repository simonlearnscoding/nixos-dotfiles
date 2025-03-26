{ config, pkgs, ... }: {
  users.users.ci = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # YOUR PUBLIC KEY HERE (cat ~/.ssh/nixos-ci-key.pub)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICc897XyaRWFS4/5RY0aYYgHocj/hpf2CTEgx4VM+K03 simon@simon-pc"
    ];
    extraGroups = [ "wheel" ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false; # Disable password for ALL sudo commands
    extraConfig = ''
      Defaults:ci !requiretty
    '';
  };
}
