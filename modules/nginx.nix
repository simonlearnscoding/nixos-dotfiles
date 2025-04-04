{
  config,
  pkgs,
  ...
}: {
services.nginx = {
  enable = true;
  virtualHosts."syncthing-proxy" = {
    listen = [{ addr = "127.0.0.1"; port = 3001; }];
    
    locations."/syncthing/" = {
      extraConfig = ''
        # Strip /syncthing prefix when forwarding
        rewrite ^/syncthing(/.*)$ $1 break;
        proxy_pass http://127.0.0.1:8384;
        
        # Essential headers
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        
        # Fix ALL paths in responses
        sub_filter_once off;
        sub_filter_types *;  # Apply to all content types
        
        # HTML/JS/CSS path rewrites
        sub_filter 'href="/' 'href="/syncthing/';
        sub_filter 'src="/' 'src="/syncthing/';
        sub_filter 'url(/' 'url(/syncthing/';
        sub_filter "url('/" "url('/syncthing/";
        sub_filter 'url("/' 'url("/syncthing/';
        sub_filter "='/" "='/syncthing/";
        sub_filter '="/' '="/syncthing/';
        
        # Fix API/redirect paths
        sub_filter '"/rest/' '"/syncthing/rest/';
        sub_filter 'Location: /' 'Location: /syncthing/';
        
        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
      '';
    };
    
    # Handle static assets separately
    locations."/syncthing/vendor/" {
      proxy_pass http://127.0.0.1:8384/vendor/;
    }
  };
};
}
