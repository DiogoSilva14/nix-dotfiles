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
}
