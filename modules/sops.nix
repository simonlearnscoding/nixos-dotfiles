{
  pkgs,
  inputs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    sops
  ];
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ./../secrets/sops.yaml;
  sops.defaultSopsFormat = "yaml";

  # TODO: simon should probably be a var that I pass
  sops.age.keyFile = "/home/simon/.config/sops/age/keys.txt";

  sops.secrets.example-key = {};
  sops.secrets."myservice/my_subdir/my_secret" = {
    owner = "sometestservice";
  };

  # systemd.services."sometestservice" = {
  #   script = ''
  #     echo "
  #     Hey bro! I'm a service, and imma send this secure password:
  #     $(cat ${config.sops.secrets."myservice/my_subdir/my_secret".path})
  #     located in:
  #     ${config.sops.secrets."myservice/my_subdir/my_secret".path}
  #     to database and hack the mainframe
  #     " > /var/lib/sometestservice/testfile
  #   '';
  #   serviceConfig = {
  #     User = "sometestservice";
  #     WorkingDirectory = "/var/lib/sometestservice";
  #   };
  # };
  #
  # users.users.sometestservice = {
  #   home = "/var/lib/sometestservice";
  #   createHome = true;
  #   isSystemUser = true;
  #   group = "sometestservice";
  # };
  # users.groups.sometestservice = {};
}
