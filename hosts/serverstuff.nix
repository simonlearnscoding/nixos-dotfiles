# hosts/common.nix
{...}: {
  imports = [
    ./../modules/syncthing.nix
    ./../modules/websites/default.nix
    ./../modules/plex.nix
    # ./../modules/nginx.nix
  ];
}
