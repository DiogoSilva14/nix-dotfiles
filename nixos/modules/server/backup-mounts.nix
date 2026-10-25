{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cifs-utils ];
  environment.etc.crypttab.text = ''
    external_hdd UUID=e8b9159c-8144-486b-8563-60981a256288 none luks,nofail
  '';

  fileSystems."/mnt/hetzner" = {
    device = "//u690546.your-storagebox.de/backup";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.sops.secrets.hetzner_env.path}" "nofail"];
  };

  fileSystems."/mnt/external_hdd" = {
    device = "/dev/mapper/external_hdd";
    fsType = "ext4";
    options = let
      automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts}" "nofail"];
  };
}
