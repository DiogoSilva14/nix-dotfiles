{ config, ... }:
{
  virtualisation.oci-containers.containers = {
    pihole = {
      image = "pihole/pihole:2026.05.0";

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
  };
}
