{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/hetzner" = {
    device = "//u690546.your-storagebox.de/backup";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.sops.secrets.hetzner_env.path}" "nofail"];
  };
}
