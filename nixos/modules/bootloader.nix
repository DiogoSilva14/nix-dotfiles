{
#  boot.loader.grub.enable = true;
#  boot.loader.grub.device = "/dev/nvme0n1p4";
#  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
