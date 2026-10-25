{
  virtualisation.oci-containers.containers = {
    bazarr = {
      image = "linuxserver/bazarr:1.6.2";

      autoStart = true;

      ports = [
        "127.0.0.1:6767:6767/tcp"
      ];

      volumes = [
        "/data/containers/bazarr/config:/config"
        "/data/media:/media"
      ];
    };
  };
}
