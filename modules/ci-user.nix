# making a new user ci that can run nixos-rebuild with no password needed
# so I will be able to do it through ssh or somethin
{pkgs, ...}: {
  security.sudo.extraRules = [
    {
      users = ["ci"];
      commands = [
        {
          command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
          options = ["NOPASSWD" "SETENV"];
        }
      ];
    }
  ];

  users.users.ci = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "command=\"sudo nixos-rebuild switch --flake /home/simon/nixos-dotfiles#server\" ssh-ed25519 AAA...your-key..."
    ];
  };
}
