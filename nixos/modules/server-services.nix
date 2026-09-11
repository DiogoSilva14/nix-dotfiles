{ config, pkgs, lib, ... }:
{
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.oci-containers = {
    backend = "docker";

    containers = {
      pihole = {
        image = "pihole/pihole:latest";

        autoStart = true;

        ports = [
          "53:53/tcp"
          "53:53/udp"
          "8081:80/tcp"
        ];

        volumes = [
          "/data/containers/pihole/etc-pihole:/etc/pihole"
          "/data/containers/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
        ];

        environmentFiles = [
          config.sops.secrets.pihole_env.path
        ];

        environment = {
          TZ = "Europe/Paris";
          FTLCONF_dns_listeningMode = "ALL";
        };
      };

      couchdb = {
        image = "couchdb:latest";

        autoStart = true;

        ports = [
          "5984:5984/tcp"
        ];

        volumes = [
          "/data/containers/couchdb/data:/opt/couchdb/data"
          "/data/containers/couchdb/local.ini:/opt/couchdb/etc/local.ini"
        ];
      };

      jellyfin = {
        image = "jellyfin/jellyfin:latest";

        autoStart = true;

        ports = [
          "8096:8096/tcp"
          "7359:7359/tcp"
        ];

        volumes = [
          "/data/containers/jellyfin/config:/config"
          "/data/containers/jellyfin/cache:/cache"
          "/data/media:/media:ro"
        ];

        extraOptions = [
          "--device=/dev/dri/renderD128:/dev/dri/renderD128"
          "--group-add=${toString config.users.groups.render.gid}"
        ];
      };

      nextcloud-db = {
        image = "mariadb:lts";

        autoStart = true;

        volumes = [
          "/data/containers/nextcloud-db/data:/var/lib/mysql"
        ];

        environmentFiles = [
          config.sops.secrets.nextcloud_env.path
        ];

        environment = {
          MYSQL_DATABASE = "nextcloud";
          MYSQL_USER = "nextcloud";
        };

        extraOptions = [ "--network=nextcloud" ];

        cmd = [
          "--transaction-isolation=READ-COMMITTED"
        ];
      };

      nextcloud-redis = {
        image = "redis:alpine";

        autoStart = true;

        extraOptions = [ "--network=nextcloud" ];
      };

      nextcloud = {
        image = "nextcloud:latest";

        autoStart = true;

        dependsOn = [
          "nextcloud-db"
          "nextcloud-redis"
        ];

        ports = [
          "8080:80"
        ];

        volumes = [
          "/data/containers/nextcloud/data:/var/www/html"
        ];

        environmentFiles = [
          config.sops.secrets.nextcloud_env.path
        ];

        environment = {
          MYSQL_DATABASE = "nextcloud";
          MYSQL_USER = "nextcloud";
        };

        extraOptions = [ "--network=nextcloud" ];
      };

      qbittorrent = {
        image = "lscr.io/linuxserver/qbittorrent:latest";

        autoStart = true;

        volumes = [
          "/data/downloads:/downloads"
          "/data/containers/qbittorrent/appdata:/config"
        ];

        environment = {
          PUID = "1000";
          PGID = "1000";
          WEBUI_PORT = "8090";
        };

        extraOptions = [ "--network=host" ];
      };

      homeassistant = {
        image = "ghcr.io/home-assistant/home-assistant:stable";

        autoStart = true;

        volumes = [
          "/data/containers/homeassistant/config:/config"
          "/etc/localtime:/etc/localtime:ro"
          "/run/dbus:/run/dbus:ro"
        ];

        extraOptions = [
          "--device=/dev/zigbee_adapter:/dev/ttyACM0"
          "--network=host"
          "--privileged"
        ];
      };
    };
  };

  systemd.services.create-nextcloud-network = {
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      ${pkgs.docker}/bin/docker network inspect nextcloud >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create nextcloud
    '';
  };

  systemd.services.glances = {
    description = "Glances system monitor";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
       ExecStart = "${pkgs.glances}/bin/glances -w";
       Restart = "always";
    };
  };
}
