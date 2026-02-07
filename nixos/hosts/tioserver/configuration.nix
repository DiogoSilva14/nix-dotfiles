{ config, lib, pkgs, ... }:
let 
  luksCryptenroller = pkgs.writeTextFile {
    name = "luksCryptenroller";
    destination = "/bin/luksCryptenroller";
    executable = true;

    text = let
      luksDevice01 = "/dev/disk/by-label/NIXLUKS";
    in ''
      sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+2+7+12 ${luksDevice01}
    '';
  };
  rebuild = pkgs.writeTextFile {
    name = "rebuild";
    destination = "/bin/rebuild";
    executable = true;

    text = ''
      sudo nixos-rebuild switch --flake ~/nix-dotfiles#$(hostname)
    '';
  };
  rebuildEncrypt = pkgs.writeTextFile {
    name = "rebuildEncrypt";
    destination = "/bin/rebuildEncrypt";
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
  services.tailscale.enable = true;
  services.couchdb = {
    enable = true;
    configFile = "/data/couchdb/local.ini";
    logFile = "/data/couchdb/couchdb.log";
    databaseDir = "/data/couchdb";
  };

  services.home-assistant = {
    enable = true;
    configDir = "/data/home-assistant";
    config = {
      default_config = {};
    };
    extraComponents = [
      "default_config" 
      "systemmonitor" 
      "esphome" 
      "mqtt" 
    ];
    extraPackages = python3Packages: with python3Packages; [
       glances-api
    ];
  };

  systemd.services.glances = {
    description = "Glances system monitor";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
       ExecStart = "${pkgs.glances}/bin/glances -w";
       Restart = "always";
    };
  };

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
    rebuild
    rebuildEncrypt
    vim
    wget
    sbctl
    tpm2-tss
    git
  ];

  system.stateVersion = "25.11";
}

