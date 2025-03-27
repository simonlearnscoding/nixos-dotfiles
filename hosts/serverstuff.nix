# hosts/common.nix
{...}: {
  imports = [
    ./../modules/cloudflare-tunnel.nix
    ./../modules/syncthing.nix
    ./../modules/plex.nix
  ];
}
