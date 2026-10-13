{ config, pkgs, ... }:
{
  services.restic.backups.volumes = {
    paths = [
      "/data/containers/couchdb"
      "/data/containers/nextcloud"
      "/data/containers/nextcloud-db"
    ];

    repository = "/mnt/hetzner/restic/docker_volumes";
    passwordFile = config.sops.secrets.restic-password.path;

    initialize = true;

    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };

    pruneOpts = [
      "--keep-last 1"
    ];
  };

  systemd.services.restic-backups-volumes = {
    requires = [ "mnt-hetzner.mount" ];
    after = [ "mnt-hetzner.mount" ];

    preStart = ''
      if ! ${pkgs.util-linux}/bin/mountpoint -q /mnt/hetzner; then
        echo "ERROR: /mnt/hetzner is not mounted; aborting backup."
        exit 1
      fi
    '';
  };
}
