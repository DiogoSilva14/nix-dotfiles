{ config, pkgs, ... }:
{
  services.restic.backups.volumes-hetzner = {
    paths = [
      "/data/containers/couchdb"
      "/data/containers/homeassistant"
      "/data/containers/homepage"
      "/data/containers/immich"
      "/data/containers/nextcloud"
      "/data/containers/nextcloud-db"
      "/data/shares/photography"
    ];

    repository = "/mnt/hetzner/restic/docker_volumes";
    passwordFile = config.sops.secrets.restic-password.path;

    initialize = true;

    timerConfig = {
      OnCalendar = "04:00";
      Persistent = true;
    };

    backupPrepareCommand = ''
      if ! ${pkgs.util-linux}/bin/mountpoint -q /mnt/hetzner; then
        echo "ERROR: /mnt/hetzner is not mounted; aborting backup."
        exit 1
      fi

      systemctl stop docker-couchdb.service
      systemctl stop docker-homeassistant.service
      systemctl stop docker-homepage.service
      systemctl stop docker-immich-server.service
      systemctl stop docker-immich-machine-learning.service
      systemctl stop docker-immich-postgres.service
      systemctl stop docker-immich-redis.service
      systemctl stop docker-nextcloud.service
      systemctl stop docker-nextcloud-db.service
      systemctl stop docker-nextcloud-redis.service
    '';

    backupCleanupCommand = ''
      systemctl start docker-couchdb.service
      systemctl start docker-homeassistant.service
      systemctl start docker-homepage.service
      systemctl start docker-immich-machine-learning.service
      systemctl start docker-immich-postgres.service
      systemctl start docker-immich-redis.service
      systemctl start docker-immich-server.service
      systemctl start docker-nextcloud-db.service
      systemctl start docker-nextcloud-redis.service
      systemctl start docker-nextcloud.service
    '';

    pruneOpts = [
      "--keep-last 5"
    ];
  };

  services.restic.backups.volumes-hdd = {
    paths = [
      "/data/containers/couchdb"
      "/data/containers/homeassistant"
      "/data/containers/homepage"
      "/data/containers/immich"
      "/data/containers/nextcloud"
      "/data/containers/nextcloud-db"
      "/data/shares/photography"
    ];

    repository = "/mnt/external_hdd/restic/docker_volumes";
    passwordFile = config.sops.secrets.restic-password.path;

    initialize = true;

    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };

    backupPrepareCommand = ''
      if ! ${pkgs.util-linux}/bin/mountpoint -q /mnt/external_hdd; then
        echo "ERROR: /mnt/external_hdd is not mounted; aborting backup."
        exit 1
      fi
    '';

    pruneOpts = [
      "--keep-last 24"
    ];
  };
}
