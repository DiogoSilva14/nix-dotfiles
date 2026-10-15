{
  sops.age.keyFile = "/home/dps/.config/sops/age/keys.txt";

  sops.secrets.pihole_env = {
    sopsFile = ../../../secrets/pihole.env;
    format = "dotenv";
  };

  sops.secrets.nextcloud_env = {
    sopsFile = ../../../secrets/nextcloud.env;
    format = "dotenv";
  };

  sops.secrets.hetzner_env = {
    sopsFile = ../../../secrets/hetzner.env;
    format = "dotenv";
  };

  sops.secrets.restic-password = {
    sopsFile = ../../../secrets/restic.yaml;
    format = "yaml";
  };

  sops.secrets.immich_env = {
    sopsFile = ../../../secrets/immich.env;
    format = "dotenv";
  };

  sops.secrets.tls_cert = {
    sopsFile = ../../../secrets/caddy-tls.yaml;
    format = "yaml";
    owner = "caddy";
    group = "caddy";
    mode = "0400";
  };

  sops.secrets.tls_key = {
    sopsFile = ../../../secrets/caddy-tls.yaml;
    format = "yaml";
    owner = "caddy";
    group = "caddy";
    mode = "0400";
  };

  sops.secrets.desec_token = {
    sopsFile = ../../../secrets/desec.env;
    format = "dotenv";
    owner = "caddy";
    group = "caddy";
    mode = "0400";
  };
}
