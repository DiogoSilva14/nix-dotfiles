{ config, lib, pkgs, ... }:
let 
  luksCryptenroller = pkgs.writeTextFile {
    name = "luksCryptenroller";
    destination = "/bin/luksCryptenroller";
    executable = true;

    text = let
      luksDevice01 = "NIXLUKS";
    in ''
      sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+2+7+12 /dev/disk/by-label/${luksDevice01}
    '';
  };
  rebuildServer = pkgs.writeTextFile {
    name = "rebuildServer";
    destination = "/bin/rebuildServer";
    executable = true;

    text = ''
      sudo nixos-rebuild switch --flake ~/nix-dotfiles#$(hostname) && luksCryptenroller
    '';
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  networking.hostName = "tioserver";

  services.openssh.enable = true;

  networking.networkmanager.enable = true; 
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "Europe/Vienna";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pt-latin9";

  users.users.dps = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
  };
  
  environment.systemPackages = with pkgs; [
    luksCryptenroller
    rebuildServer
    vim
    wget
    sbctl
    tpm2-tss
    git
  ];

  system.stateVersion = "25.11";
}

