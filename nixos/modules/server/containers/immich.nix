{ config, pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    immich-postgres = {
      image = "ghcr.io/immich-app/postgres:14-vectorchord0.3.0";

      autoStart = true;

      volumes = [
        "/data/containers/immich/postgres:/var/lib/postgresql/data"
      ];

      environmentFiles = [
        config.sops.secrets.immich_env.path
      ];

      extraOptions = [ "--network=immich" ];
    };

    immich-redis = {
      image = "docker.io/valkey/valkey:9@sha256:418652cfb58ef879d4978c33553735d7147016032d5aefaa14c828e611eb9dfd";

      autoStart = true;

      extraOptions = [ "--network=immich" ];
    };

    immich-machine-learning = {
      image = "ghcr.io/immich-app/immich-machine-learning:v3.3.1";

      autoStart = true;

      volumes = [
        "/data/containers/immich/model-cache:/cache"
      ];

      environment = {
        MACHINE_LEARNING_MODEL_REVISION = "v2";
      };

      extraOptions = [ "--network=immich" ];
    };

    immich-server = {
      image = "ghcr.io/immich-app/immich-server:v3.3.1";

      autoStart = true;

      ports = [
        "127.0.0.1:2283:2283/tcp"
      ];

      volumes = [
        "/data/containers/immich/library:/data"
        "/etc/localtime:/etc/localtime:ro"
      ];

      dependsOn = [
        "immich-machine-learning"
        "immich-redis"
        "immich-postgres"
      ];

      environmentFiles = [
        config.sops.secrets.immich_env.path
      ];

      environment = {
        TZ = "Europe/Vienna";
      };

      extraOptions = [
        "--device=/dev/dri:/dev/dri"
        "--network=immich"
      ];
    };
  };

  systemd.services.create-immich-network = {
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      ${pkgs.docker}/bin/docker network inspect immich >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create immich
    '';
  };
}
