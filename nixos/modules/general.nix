{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.tailscale.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  sops.age.keyFile = "/home/dps/.config/sops/age/keys.txt";
  sops.secrets.smb_env = {
    sopsFile = ../../secrets/smb.env;
    format = "dotenv";
  };

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/photography" = {
    device = "//tioserver/photography";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.sops.secrets.smb_env.path},uid=1000,gid=100" "nofail"];
  };
}
