{
  virtualisation.oci-containers.containers = {
    homeassistant = {
      image = "ghcr.io/home-assistant/home-assistant:2026.5.4";

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
}
