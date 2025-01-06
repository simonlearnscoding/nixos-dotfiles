# hosts/common.nix
{...}: {
  imports = [
    ./../modules/plex.nix
  ];
}
