{
  virtualisation.oci-containers.containers = {
    homeassistant = {
      image = "ghcr.io/home-assistant/home-assistant:2026.10.1";

      autoStart = true;

      ports = [
        "127.0.0.1:8123:8123/tcp"
      ];

      volumes = [
        "/data/containers/homeassistant/config:/config"
        "/etc/localtime:/etc/localtime:ro"
        "/run/dbus:/run/dbus:ro"
      ];

      extraOptions = [
        "--device=/dev/zigbee_adapter:/dev/ttyACM0"
#        "--network=host"
#        "--privileged"
      ];
    };
  };
}
