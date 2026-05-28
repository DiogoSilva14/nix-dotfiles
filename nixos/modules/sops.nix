{
  sops.age.keyFile = "/home/dps/.config/sops/age/keys.txt";

  sops.secrets.pihole_env = {
    sopsFile = ../../secrets/pihole.env;
    format = "dotenv";
  };

  sops.secrets.nextcloud_env = {
    sopsFile = ../../secrets/nextcloud.env;
    format = "dotenv";
  };
}
