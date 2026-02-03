{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/eb1dd286-f1c9-41db-817c-34c180eed5e1";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2961-0B66";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  boot.kernelParams = [
    "resume_offset=33198080"
    "mem_sleep_default=s2idle"
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/eb1dd286-f1c9-41db-817c-34c180eed5e1";
  powerManagement.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLibSwitchDocker = "ignore";
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=60m
    SuspendState=mem
  '';
  powerManagement.powertop.enable = true;
  services.udev.extraRules = ''
  ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x8086" ATTR{device}=="0x51b9" ATTR{power/wakeup}="disabled"
'';

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 17 * 1024; # 17GB
  }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.fwupd.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        nvtopPackages.intel
    ];
  };

}
