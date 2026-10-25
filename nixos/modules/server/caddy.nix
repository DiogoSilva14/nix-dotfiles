{ config, pkgs, ... }:
let
  domain = "tiohome.world";
in
{
  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/desec@v1.1.0" ];
      hash = "sha256-CpfQSS+dWFNhnTfo9TEDyRnsMtZScvyL+5/4gd82pI0=";
    };

    virtualHosts."*.${domain}".extraConfig = ''
      tls {
        dns desec {
          token {env.DESEC_TOKEN}
        }

        propagation_delay 2m
        propagation_timeout 5m

        resolvers 1.1.1.1 1.0.0.1
      }

      @immich host immich.${domain}
      handle @immich { reverse_proxy 127.0.0.1:2283 }

      @bazarr host bazarr.${domain}
      handle @bazarr { reverse_proxy 127.0.0.1:6767 }

      @couchdb host couchdb.${domain}
      handle @couchdb { reverse_proxy 127.0.0.1:5984 }

      @homeassistant host homeassistant.${domain}
      handle @homeassistant { reverse_proxy 127.0.0.1:8123 }

      @jellyfin host jellyfin.${domain}
      handle @jellyfin { reverse_proxy 127.0.0.1:8096 }

      @nextcloud host nextcloud.${domain}
      handle @nextcloud { reverse_proxy 127.0.0.1:8080 }

      @qbittorrent host qbittorrent.${domain}
      handle @qbittorrent { reverse_proxy 127.0.0.1:8090 }

      @glances host glances.${domain}
      handle @glances { reverse_proxy 127.0.0.1:61208 }

      @homepage host homepage.${domain}
      handle @homepage { reverse_proxy 127.0.0.1:3000 }

      handle {
        abort
      }
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = "${config.sops.secrets.desec_token.path}";
}
