# hosts/common.nix
{...}: {
  imports = [
    ./../modules/server/syncthing.nix
    ./../modules/server/cloudflared.nix
    ./../modules/server/caddy.nix
    ./../modules/server/media-stack.nix
    # ./../modules/nginx.nix
  ];
}
