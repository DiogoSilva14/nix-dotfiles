{
  virtualisation.oci-containers.containers = {
    homepage = {
      image = "ghcr.io/gethomepage/homepage:v1.13.2";

      autoStart = true;

      ports = [
        "127.0.0.1:3000:3000/tcp"
      ];

      volumes = [
        "/data/containers/homepage:/app/config"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];

      environment = {
        TZ = "Europe/Vienna";
        HOMEPAGE_ALLOWED_HOSTS = "homepage.tiohome.world";
      };
    };
  };
}
