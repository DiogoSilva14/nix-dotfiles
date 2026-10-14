{ config, pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    nextcloud-db = {
      image = "mariadb:11.8-noble";

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
      image = "redis:8.6.3";

      autoStart = true;

      extraOptions = [ "--network=nextcloud" ];
    };

    nextcloud = {
      image = "nextcloud:stable";

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
  };

  systemd.services.create-nextcloud-network = {
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      ${pkgs.docker}/bin/docker network inspect nextcloud >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create nextcloud
    '';
  };
}
