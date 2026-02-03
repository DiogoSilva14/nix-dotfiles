{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/bundle.nix
    ../../packages.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "tiolaptop";

  services.flatpak.enable = true;
  services.tailscale.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "25.11"; # State version. Not sure if needed with flakes :/
}
