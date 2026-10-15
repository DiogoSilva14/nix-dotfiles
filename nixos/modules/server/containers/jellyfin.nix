{ config, ... }:
{
  virtualisation.oci-containers.containers = {
    jellyfin = {
      image = "jellyfin/jellyfin:10.11.9";

      autoStart = true;

      ports = [
        "127.0.0.1:8096:8096/tcp"
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
  };
}
