# hosts/common.nix
{...}: {
  imports = [
    ./../modules/plex.nix

    ./../modules/syncthing.nix
  ];
}
